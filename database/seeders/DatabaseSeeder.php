<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    private $permissions = [
        ['View Employees', 'view.employees', null],
        ['Create Employees', 'create.employees', 1],
        ['Edit Employees', 'edit.employees', 1],
        ['Toggle Employees', 'toggle.employees', 1],
        ['Change Employee Password', 'change.employee.password', 1],
        ['View Categories', 'view.categories', null],
        ['Create Categories', 'create.categories', 6],
        ['Edit Categories', 'edit.categories', 6],
        ['Toggle Categories', 'toggle.categories', 6],
        ['View Departments', 'view.departments', null],
        ['Create Departments', 'create.departments', 10],
        ['Edit Departments', 'edit.departments', 10],
        ['Toggle Departments', 'toggle.departments', 10],
        ['View Rooms', 'view.rooms', null],
        ['Create Rooms', 'create.rooms', 14],
        ['Edit Rooms', 'edit.rooms', 14],
        ['Toggle Rooms', 'toggle.rooms', 14],
        ['View Inventory Suppliers', 'view.suppliers.inventory', null],
        ['Create Inventory Suppliers', 'create.suppliers.inventory', 18],
        ['Edit Inventory Suppliers', 'edit.suppliers.inventory', 18],
        ['Toggle Inventory Suppliers', 'toggle.suppliers.inventory', 18],
        ['View Equipment Suppliers', 'view.suppliers.equipment', null],
        ['Create Equipment Suppliers', 'create.suppliers.equipment', 22],
        ['Edit Equipment Suppliers', 'edit.suppliers.equipment', 22],
        ['Toggle Equipment Suppliers', 'toggle.suppliers.equipment', 22],
        ['View Equipment Supplier Engineers', 'view.equipment.supplier.engineers', 22],
        ['Create Equipment Supplier Engineers', 'create.equipment.supplier.engineers', 26],
        ['Edit Equipment Supplier Engineers', 'edit.equipment.supplier.engineers', 26],
        ['View Medicine Suppliers', 'view.suppliers.medicine', null],
        ['Create Medicine Suppliers', 'create.suppliers.medicine', 29],
        ['Edit Medicine Suppliers', 'edit.suppliers.medicine', 29],
        ['Toggle Medicine Suppliers', 'toggle.suppliers.medicine', 29],
        ['View Items', 'view.items', null],
        ['Create Items', 'create.items', 33],
        ['Edit Items', 'edit.items', 33],
        ['Toggle Items', 'toggle.items', 33],
        ['Toggle Items Assignment', 'toggle.items.assign', 33],
        ['View Item Qrs', 'view.item.qrs', 33],
        ['Create Item Qrs', 'create.item.qrs', 33],
        ['Edit Item Qrs', 'edit.item.qrs', 33],
        ['View Employee Roles', 'view.roles', null],
        ['Create Employee Roles', 'create.roles', 41],
        ['Edit Employee Roles', 'edit.roles', 41],
        ['View Factories', 'view.factories', null],
        ['Create Factories', 'create.factories', 44],
        ['Edit Factories', 'edit.factories', 44],
        ['Toggle Factories', 'toggle.factories', 44],
        ['View Equipments', 'view.equipments', null],
        ['Create Equipments', 'create.equipments', 48],
        ['Edit Equipments', 'edit.equipments', 48],
        ['Toggle Equipments', 'toggle.equipments', 48],
        ['View Equipment Details', 'view.equipment.details', 48],
        ['Create Equipment Services', 'create.equipment.services', 48],
        ['View Equipment Services', 'view.equipment.services', 48],
        ['Edit Equipment Services', 'edit.equipment.services', 54],
        ['View Workshops', 'view.workshops', null],
        ['Create Workshops', 'create.workshops', 56],
        ['Edit Workshops', 'edit.workshops', 56],
        ['Delete Workshops', 'toggle.workshops', 56],
        ['View Medicines', 'view.medicines', null],
        ['Create Medicines', 'create.medicines', 60],
        ['Edit Medicines', 'edit.medicines', 60],
        ['Toggle Medicines', 'toggle.medicines', 60],
        ['View Medicines Inventories', 'view.medicines.inventories', null],
        ['Create Medicines Inventories', 'create.medicines.inventories', 64],
        ['Edit Medicines Inventories', 'edit.medicines.inventories', 64],
        ['View Medicines Orders', 'view.medicines.orders', null],
        ['Create Medicines Orders', 'create.medicines.orders', 67],
        ['Edit Medicines Orders', 'edit.medicines.orders', 67],
        ['Toggle Medicines Orders', 'toggle.medicines.orders', 67],
        ['View Medicines Requests', 'view.medicines.requests', null],
        ['Create Medicines Requests', 'create.medicines.requests', 71],
        ['Edit Medicines Requests', 'edit.medicines.requests', 71],
        ['Approve Medicines Requests', 'approve.medicines.requests', 71],
        ['Dispense Medicines Requests', 'dispense.medicines.requests', 71],
        ['View Medicines Movement Report', 'view.medicines.movement', null],
        ['View Medicines Expiry Report', 'view.medicines.expiration', null],
        ['View Medicines Departments Request', 'view.medicines.departments.request', null]
    ];

    private $panels = [
        ['Admin Panel', 'admin.home'],
        ['Inventory Management', 'inventory.home'],
        ['Pharmacy', 'pharmacy.home'],
        ['Equipment', 'equipments.home'],
        ['Temperature Monitoring', 'temperature.monitoring.home'],
        ['Newborn Protection', 'protect.newborn.home'],
        ['Medical Devices Maintenance', 'medical.devices.home']
    ];

    private $roles = [
        'super admin',
        'head of department',
        'room manager',
        'head of nurses',
        'head of pharmacy',
        'pharmacist',
        'head of pharmacist',
    ];

    public function run()
    {
        \App\Models\Department::create([
            'title' => 'Depart',
            'created_at' => now()->format('Y-m-d H:i:s'),
            'updated_at' => now()->format('Y-m-d H:i:s')
        ]);

        \App\Models\Category::create([
            'name' => 'Demo',
            'status' => 1,
            'created_at' => now()->format('Y-m-d H:i:s'),
            'updated_at' => now()->format('Y-m-d H:i:s')
        ]);

        foreach ($this->panels as $panel) {
            \App\Models\Panel::create([
                'title' => $panel[0],
                'slug' => $panel[1],
                'created_at' => now()->format('Y-m-d H:i:s'),
                'updated_at' => now()->format('Y-m-d H:i:s')
            ]);
        }

        foreach ($this->permissions as $permission) {
            $p = \App\Models\Permission::create([
                'title' => $permission[0],
                'slug' => $permission[1],
                'parent_id' => $permission[2],
            ]);

            if ($p->id >= 1 && $p->id <= 47) {
                $p->panels()->syncWithoutDetaching([1]);
                if ($p->id >= 18 && $p->id <= 40) {
                    $p->panels()->syncWithoutDetaching([2]);
                }
            } else if ($p->id >= 48 && $p->id <= 59) {
                $p->panels()->syncWithoutDetaching([4]);
            } else if ($p->id >= 60 && $p->id <= 77) {
                $p->panels()->syncWithoutDetaching([3]);
            }
        }

        foreach ($this->roles as $role) {
            $r = \App\Models\Role::create([
                'name' => $role,
                'is_user' => 1,
                'created_at' => now()->format('Y-m-d H:i:s'),
                'updated_at' => now()->format('Y-m-d H:i:s')
            ]);
            if ($r->id == 1) {
                $r->panels()->sync([1, 2, 3, 4]);
            }
        }

        $employee = \App\Models\Employee::create([
            'name' => 'admin',
            'number' => '007',
            'email' => 'admin@gmail.com',
            'phone' => '00700000000',
            'role_id' => 1,
            'gender' => 1,
            'created_at' => now()->format('Y-m-d H:i:s'),
            'updated_at' => now()->format('Y-m-d H:i:s')
        ]);

        $employee->account()->create([
            'email' => 'admin@gmail.com',
            'password' => '$2y$10$wxmWDIfqpnCrpWOwPeRGuemofWnLUCSfkZHRyPLBV8F.WVczYJ0QC',
            'status' => 1,
            'created_at' => now()->format('Y-m-d H:i:s'),
            'updated_at' => now()->format('Y-m-d H:i:s')
        ]);
    }
}
