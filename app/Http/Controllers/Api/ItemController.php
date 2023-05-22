<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\DepartmentResource;
use App\Http\Resources\FactoryResource;
use App\Http\Resources\ItemResource;
use App\Http\Resources\MainCategoryResource;
use App\Http\Resources\SupplierResource;
use App\Models\Category;
use App\Models\Department;
use App\Models\Factory;
use App\Models\Item;
use App\Models\Supplier;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;

class ItemController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        // $auth = auth()->user()->load('department');
        $departments = Department::has('employees')->latest()->get();
        $mains = Category::withAndHas('subCategories')->latest()->get();
        $factories = Factory::latest()->get();
        // if (!isset($auth->department)) {
        //     $items = Item::with('subCategory.category')->latest()->get();
        // } else {
        $items = Item::with('subCategory.category', 'factory')->latest()->get();
        // }
        return [
            'mains' =>  MainCategoryResource::collection($mains),
            'departments' => DepartmentResource::collection($departments),
            'factories' => FactoryResource::collection($factories),
            'items' => ItemResource::collection($items),
        ];
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'name' => 'required|string|min:2|max:255',
                'description' => 'required|string|min:5|max:255',
                'sub_category' => 'required|integer|exists:sub_categories,id',
                'factory' => 'required|integer|exists:factories,id'
            ]);

            $item = new Item();
            $item->name = $request->name;
            $item->description = $request->description;
            $item->sub_category_id = $request->sub_category;
            $item->factory_id = $request->factory;
            $item->status = 1;
            $item->save();
            return response()->json([
                'message' => 'Item created successfully.',
                'success' => true,
                'item' => new ItemResource($item->load('subCategory.category', 'factory'))
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
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function show(Item $item)
    {
        $suppliers = Supplier::get();
        $item->load('subCategory.category');
        return ['suppliers' => SupplierResource::collection($suppliers), 'item' => new ItemResource($item)];
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Item $item)
    {
        try {
            $request->validate([
                'name' => 'required|string|min:2|max:255',
                'description' => 'required|string|min:5|max:255',
                'sub_category' => 'required|integer|exists:sub_categories,id',
                'factory' => 'required|integer|exists:factories,id'
            ]);

            $item->name = $request->name;
            $item->description = $request->description;
            $item->sub_category_id = $request->sub_category;
            $item->factory_id = $request->factory;
            $item->save();
            return response()->json([
                'message' => 'Item updated successfully.',
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
     * @param  \App\Models\Item  $item
     * @return \Illuminate\Http\Response
     */
    public function destroy(Item $item)
    {
        //
    }

    public function toggle(Item $item)
    {
        $item->status = $item->status == 1 ? 0 : 1;
        if ($item->status == 1) {
            $msg = 'Item has been activated successfully';
        } else {
            $msg = 'Item has been deactivated successfully';
        }
        if ($item->save()) {
            return response()->json(['message' => $msg, 'success' => true], 200);
        }
    }
}
