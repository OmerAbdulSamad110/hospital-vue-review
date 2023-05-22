<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Laravel\Fortify\Http\Controllers\AuthenticatedSessionController;
use Laravel\Fortify\Http\Controllers\NewPasswordController;
use Laravel\Fortify\Http\Controllers\PasswordResetLinkController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['prefix' => 'v1'], function () {
    Route::middleware('guest:sanctum')->group(function () {
        Route::post('/login', [AuthenticatedSessionController::class, 'store'])->middleware('throttle:login');
        Route::post('/forgot-password', [PasswordResetLinkController::class, 'store']);
        Route::post('/reset-password', [NewPasswordController::class, 'store']);
    });

    Route::middleware('auth:sanctum')->group(function () {
        Route::post('/logout', [AuthenticatedSessionController::class, 'destroy']);
        Route::get('/user', function (Request $request) {
            return $request->user();
        });
        Route::group(['namespace' => 'Api'], function () {
            Route::put('employees/{employee}/toggle', 'EmployeeController@toggle');
            Route::apiResource('employees', 'EmployeeController')->except(['show', 'destroy']);

            Route::apiResource('workshops', 'WorkshopController')->except(['show']);

            Route::get('categories/{type}', 'CategoryController@index');
            Route::post('categories/{type}', 'CategoryController@store');
            Route::put('categories/{category}/{type}', 'CategoryController@update');
            Route::put('categories/{category}/{type}/toggle', 'CategoryController@toggle');

            Route::get('departments/{department}/employees/{for?}', 'DepartmentController@employees');
            Route::put('departments/{department}/toggle', 'DepartmentController@toggle');
            Route::apiResource('departments', 'DepartmentController')->except(['show', 'destroy']);

            // Route::get('items/{item}/qrs', 'ItemQrController@index');
            // Route::post('items/{item}/qrs', 'ItemQrController@store');

            Route::post('item/qr/read', 'ItemQrController@read');
            Route::put('itemQrs/{itemQr}/assignment/toggle', 'ItemQrController@toggleAssignment');
            Route::apiResource('items.itemQrs', 'ItemQrController')->shallow()->except(['destroy']);

            Route::put('items/{item}/toggle', 'ItemController@toggle');
            Route::apiResource('items', 'ItemController')->except(['destroy']);


            Route::get('panels', 'HomeController@panels');

            Route::put('rooms/{room}/toggle', 'RoomController@toggle');
            Route::apiResource('rooms', 'RoomController')->except(['show', 'destroy']);

            Route::prefix('suppliers/')->group(function () {
                Route::get('{type}', 'SupplierController@index');
                Route::post('', 'SupplierController@store');
                Route::put('{supplier}', 'SupplierController@update');
                Route::put('{supplier}/toggle', 'SupplierController@toggle');

                Route::get('{supplier}/engineers', 'SupplierEngineerController@index');
                Route::post('engineers', 'SupplierEngineerController@store');
                Route::put('engineers/{engineer}', 'SupplierEngineerController@update');
            });

            Route::apiResource('roles', 'RoleController');

            Route::get('dashboard/{type}', 'HomeController@dashboard')
                ->where(['type' => 'admin|inventory|equipment|pharmacy']);

            Route::post('generate/qrs', 'ItemQrController@generateQrs');

            Route::put('factories/{factory}/toggle', 'FactoryController@toggle');
            Route::apiResource('factories', 'FactoryController');

            Route::get('assigned/items', 'HomeController@assignedItems');

            Route::get('equipments/{equipment}/services', 'EquipmentController@services');
            Route::post('equipments/services', 'EquipmentController@storeService');
            Route::put('equipments/services/{service}', 'EquipmentController@updateService');

            Route::apiResource('equipments', 'EquipmentController')
                ->except(['destroy']);


            Route::prefix('medicines/')->group(function () {
                Route::get('inventories', 'MedicineController@inventories');
                Route::post('inventories', 'MedicineController@createInventory');
                Route::put('inventories/{inventory}', 'MedicineController@updateInventory');

                Route::put('orders/{order}/status', 'MedicineController@orderStatus');
                Route::get('orders', 'MedicineController@orders');
                Route::post('orders', 'MedicineController@createOrder');
                Route::put('orders/{order}', 'MedicineController@updateOrder');
                Route::put('orders/{order}/status', 'MedicineController@orderStatus');

                Route::get('requests', 'MedicineRequestController@index');
                Route::post('requests', 'MedicineRequestController@store');
                Route::put('requests/{id}', 'MedicineRequestController@update');
                Route::put('requests/{id}/approve', 'MedicineRequestController@approve');
                Route::post('requests/{id}/dispence', 'MedicineRequestController@dispencing');

                Route::put('{medicine}/toggle', 'MedicineController@toggle');
                Route::apiResource('', 'MedicineController')
                    ->except(['destroy']);
            });
            Route::prefix('reports')->group(function () {
                Route::get('medicines/movement', 'MedicineController@movement');
                Route::get('medicines/expiration', 'MedicineController@expiration');
                Route::get('medicines/requests', 'MedicineController@orders');
                Route::get('departments/medicines/requests', 'MedicineController@department');
            });
        });
    });
});
