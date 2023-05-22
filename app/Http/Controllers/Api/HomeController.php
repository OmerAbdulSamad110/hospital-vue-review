<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\ItemQrResource;
use App\Http\Resources\PanelResource;
use App\Models\Category;
use App\Models\Department;
use App\Models\Employee;
use App\Models\Equipment;
use App\Models\Item;
use App\Models\ItemQr;
use App\Models\Medicine;
use App\Models\MedicineInventory;
use App\Models\MedicineOrder;
use App\Models\MedicineRequest;
use App\Models\Room;
use App\Models\SubCategory;
use App\Models\Supplier;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{
    public function panels()
    {
        $panels = auth()->user()->panels;
        return ['panels' => PanelResource::collection($panels)];
    }

    public function dashboard($type)
    {
        $data = [];
        if ($type == 'admin' || $type == 'inventory') {
            $data['items'] = [
                'unassigned' => ItemQr::whereNull('assigned_date')->count(),
                'assigned' => ItemQr::whereNotNull('assigned_date')->count(),
            ];
        }

        if ($type == 'admin') {
            $data = array_merge([
                'employees' => Employee::count(),
                'departments' => Department::count(),
                'categories' => Category::count() + SubCategory::count(),
                'suppliers' => Supplier::count(),
            ], $data);
        } else if ($type == 'equipment') {
            $data = [
                'equipments' => Equipment::count(),
                'suppliers' => Supplier::where('type', 2)->count()
            ];
        } else if ($type == 'pharmacy') {
            $m = now()->format('m');
            $y = now()->format('Y');
            $data = [
                'medicines' => Medicine::count(),
                'orders' => MedicineOrder::count(),
                'reports' => [
                    'requests' => MedicineRequest::sum('quantity') + 0,
                    'expirations' => MedicineInventory::whereMonth('expired_at', '<=', now()->addMonths(6)->format('m'))->count(),
                ],
                'movements' => DB::table('medicine_dispensings')
                    ->selectRaw(
                        'CAST(IFNULL(SUM(IF(MONTH(created_at) = ? AND YEAR(created_at) = ?, quantity, 0)), 0) AS UNSIGNED) AS monthly, CAST(IFNULL(SUM(IF(created_at BETWEEN ? AND ?, quantity, 0)), 0) AS UNSIGNED) AS weekly, CAST(IFNULL(SUM(IF(MONTH(created_at) != ? AND YEAR(created_at) = ?, quantity, 0)), 0) AS UNSIGNED) AS yearly',
                        [$m, $y, now()->startOfWeek(), now()->endOfWeek(), $m, $y]
                    )->get()[0]
            ];
        }

        return response()->json([
            'counts' => $data,
            'success' => true,
        ], 200);
    }

    public function assignedItems()
    {
        $items = ItemQr::with('department:id,title', 'assignor', 'assignee', 'item:id,name')
            ->where('assignee_id', auth()->user()->employee->id)->get();
        return response(['assigns' => ItemQrResource::collection($items)]);
    }
}
