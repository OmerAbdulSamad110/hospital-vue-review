<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\DepartmentResource;
use App\Models\Item;
use App\Models\ItemQr;
use App\Models\Supplier;
use Illuminate\Http\Request;
use App\Http\Resources\ItemQrResource;
use App\Http\Resources\SupplierResource;
use App\Models\Department;
use App\Rules\qrCodeCheck;
use Illuminate\Validation\ValidationException;
use BaconQrCode\Renderer\ImageRenderer;
use BaconQrCode\Renderer\Image\SvgImageBackEnd;
use BaconQrCode\Renderer\RendererStyle\RendererStyle;
use BaconQrCode\Writer;
use Zip;

class ItemQrController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Item $item)
    {
        $auth = auth()->user()->load('employee');
        $suppliers = Supplier::byType('inventory');
        $departments = Department::latest()->get();
        if ($auth->employee->role_id == 1) {
            $qrs = $item->qrs->load('department', 'supplier', 'assignor', 'assignee');
        } else {
            $qrs = $item->qrs->where('department_id', $auth->employee->department_id)->load('department', 'supplier', 'assignor', 'assignee');
        }
        return ['departments' => DepartmentResource::collection($departments), 'suppliers' => SupplierResource::collection($suppliers), 'qrs' => ItemQrResource::collection($qrs)];
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, Item $item)
    {
        try {
            $validated = $request->validate([
                'department' => 'required|integer|exists:departments,id',
                'supplier' => 'required|integer|exists:suppliers,id',
                'purchased_at' => 'required|date',
                'unique_values' => 'required|array|min:1',
                'unique_values.*' => 'required|distinct|unique:item_qrs,unique_value,null,id,item_id,' . $item->id
            ], [], [
                'unique_values.*' => 'unique value'
            ]);
            $qrs = $item->generateQrs($validated);
            return response()->json([
                'message' => 'Qr Generated successfully.',
                'success' => true,
                'qrs' => ItemQrResource::collection($qrs->load('supplier', 'department', 'assignor', 'assignee'))
            ], 200);
        } catch (\Exception $e) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            } else {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->getMessage(),
                    'trace' => $e->getTrace(),
                ], 500);
            }
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\ItemQr  $itemQr
     * @return \Illuminate\Http\Response
     */
    public function show(ItemQr $itemQr)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\ItemQr  $itemQr
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ItemQr $itemQr)
    {
        try {
            $request->validate([
                'department' => 'required|integer|exists:departments,id',
                'supplier' => 'required|integer|exists:suppliers,id',
                'unique_value' => 'required|distinct|unique:item_qrs,unique_value,' . $itemQr->id . ',id,item_id,' . $itemQr->item_id,
                'purchased_at' => 'required|date',
            ]);
            $itemQr->update([
                'department_id' => $request->department,
                'supplier_id' => $request->supplier,
                'unique_value' => $request->unique_value,
                'purchased_at' => $request->purchased_at
            ]);
            return response()->json([
                'message' => 'Qr updated successfully.',
                'success' => true,
            ], 200);
        } catch (\Exception $e) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            } else {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->getMessage(),
                    'trace' => $e->getTrace(),
                ], 500);
            }
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ItemQr  $itemQr
     * @return \Illuminate\Http\Response
     */
    public function destroy(ItemQr $itemQr)
    {
        //
    }

    public function read(Request $request)
    {
        try {
            $request->validate([
                'code' => ['bail', 'required', 'regex:/^.+\-\d+$/', new qrCodeCheck()]
            ], [], ['code' => 'qr code']);
            $arr = explode('-', $request->code);
            $itemQr = ItemQr::with('assignor', 'assignee.department')->find(end($arr));
            return response()->json([
                'message' => 'The given qr code is valid.',
                'success' => true,
                'qr' => new ItemQrResource($itemQr)
            ], 200);
        } catch (\Exception $e) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            } else {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->getMessage(),
                    'trace' => $e->getTrace(),
                ], 500);
            }
        }
    }

    public function toggleAssignment(Request $request, ItemQr $itemQr)
    {
        try {
            $request->validate([
                'employee' => 'nullable|integer|exists:employees,id'
            ]);
            $msg = 'Item assigned successfully.';
            $isAssign = isset($itemQr->assignee_id) && isset($itemQr->assignor_id);
            if ($isAssign) {
                $itemQr->assigned_date =
                    $itemQr->assignee_id =
                    $itemQr->assignor_id = null;
                $msg = 'Item unassigned successfully.';
            } else if (!$isAssign && isset($request->employee)) {
                $itemQr->assigned_date = now();
                $itemQr->assignee_id = $request->employee;
                $itemQr->assignor_id = auth()->id();
            }
            $itemQr->save();
            return response()->json([
                'assignment' => !$isAssign,
                'message' => $msg,
                'success' => true,
            ], 200);
        } catch (\Exception $e) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            } else {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->getMessage(),
                    'trace' => $e->getTrace(),
                ], 500);
            }
        }
    }

    public function generateQrs(Request $request)
    {
        try {
            $request->validate([
                'qrs' => 'required|array|min:1|distinct',
                'qrs.*' => 'required|integer|distinct|exists:item_qrs,id'
            ]);
            $qrs = ItemQr::whereIn('id', $request->qrs)->get();
            $renderer = new ImageRenderer(
                new RendererStyle(400),
                new SvgImageBackEnd()
            );
            $writer = new Writer($renderer);

            $zip = Zip::create("qrcode.zip");
            foreach ($qrs as $qr) {
                $zip->addRaw($writer->writeString("$qr->unique_value-$qr->id"), "$qr->unique_value.svg");
            }
            $file = $zip->response();
            $file->headers->set("content-disposition", "attachment; filename=qrcode.zip");
            return $file;
        } catch (\Exception $e) {
            if ($e instanceof ValidationException) {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            } else {
                return response()->json([
                    'message'    => 'Error',
                    'status' => 'error',
                    'errors' => $e->getMessage(),
                    'trace' => $e->getTrace(),
                ], 500);
            }
        }
    }
}
