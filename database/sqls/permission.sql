INSERT INTO `permissions` (`id`, `title`, `slug`, `parent_id`) VALUES
(1, 'View Employees', 'view.employees', null),
(2, 'Create Employees', 'create.employees', 1),
(3, 'Edit Employees', 'edit.employees', 1),
(4, 'Toggle Employees', 'toggle.employees', 1),
(5, 'Change Employee Password', 'change.employee.password', 1),
(6, 'View Categories', 'view.categories', null),
(7, 'Create Categories', 'create.categories', 6),
(8, 'Edit Categories', 'edit.categories', 6),
(9, 'Toggle Categories', 'toggle.categories', 6),
(10, 'View Departments', 'view.departments', null),
(11, 'Create Departments', 'create.departments', 10),
(12, 'Edit Departments', 'edit.departments', 10),
(13, 'Toggle Departments', 'toggle.departments', 10),
(14, 'View Rooms', 'view.rooms', null),
(15, 'Create Rooms', 'create.rooms', 14),
(16, 'Edit Rooms', 'edit.rooms', 14),
(17, 'Toggle Rooms', 'toggle.rooms', 14),
(18, 'View Inventory Suppliers', 'view.suppliers.inventory', null),
(19, 'Create Inventory Suppliers', 'create.suppliers.inventory', 18),
(20, 'Edit Inventory Suppliers', 'edit.suppliers.inventory', 18),
(21, 'Toggle Inventory Suppliers', 'toggle.suppliers.inventory', 18),
(22, 'View Equipment Suppliers', 'view.suppliers.equipment', null),
(23, 'Create Equipment Suppliers', 'create.suppliers.equipment', 22),
(24, 'Edit Equipment Suppliers', 'edit.suppliers.equipment', 22),
(25, 'Toggle Equipment Suppliers', 'toggle.suppliers.equipment', 22),
(26, 'View Equipment Supplier Engineers', 'view.equipment.supplier.engineers', 22),
(27, 'Create Equipment Supplier Engineers', 'create.equipment.supplier.engineers', 26),
(28, 'Edit Equipment Supplier Engineers', 'edit.equipment.supplier.engineers', 26),
(29, 'View Medicine Suppliers', 'view.suppliers.medicine', null),
(30, 'Create Medicine Suppliers', 'create.suppliers.medicine', 29),
(31, 'Edit Medicine Suppliers', 'edit.suppliers.medicine', 29),
(32, 'Toggle Medicine Suppliers', 'toggle.suppliers.medicine', 29),
(33, 'View Items', 'view.items', null),
(34, 'Create Items', 'create.items', 33),
(35, 'Edit Items', 'edit.items', 33),
(36, 'Toggle Items', 'toggle.items', 33),
(37, 'Toggle Items Assignment', 'toggle.items.assign', 33),
(38, 'View Item Qrs', 'view.item.qrs', 33),
(39, 'Create Item Qrs', 'create.item.qrs', 33),
(40, 'Edit Item Qrs', 'edit.item.qrs', 33),
(41, 'View Employee Roles', 'view.roles', null),
(42, 'Create Employee Roles', 'create.roles', 41),
(43, 'Edit Employee Roles', 'edit.roles', 41),
(44, 'View Factories', 'view.factories', null),
(45, 'Create Factories', 'create.factories', 44),
(46, 'Edit Factories', 'edit.factories', 44),
(47, 'Toggle Factories', 'toggle.factories', 44),
(48, 'View Equipments', 'view.equipments', null),
(49, 'Create Equipments', 'create.equipments', 48),
(50, 'Edit Equipments', 'edit.equipments', 48),
(51, 'Toggle Equipments', 'toggle.equipments', 48),
(52, 'View Equipment Details', 'view.equipment.details', 48),
(53, 'Create Equipment Services', 'create.equipment.services', 48),
(54, 'View Equipment Services', 'view.equipment.services', 48),
(55, 'Edit Equipment Services', 'edit.equipment.services', 54),
(56, 'View Workshops', 'view.workshops', null),
(57, 'Create Workshops', 'create.workshops', 56),
(58, 'Edit Workshops', 'edit.workshops', 56),
(59, 'Delete Workshops', 'toggle.workshops', 56),
(60, 'View Medicines', 'view.medicines', null),
(61, 'Create Medicines', 'create.medicines', 60),
(62, 'Edit Medicines', 'edit.medicines', 60),
(63, 'Toggle Medicines', 'toggle.medicines', 60),
(64, 'View Medicines Inventories', 'view.medicines.inventories', null),
(65, 'Create Medicines Inventories', 'create.medicines.inventories', 64),
(66, 'Edit Medicines Inventories', 'edit.medicines.inventories', 64),
(67, 'View Medicines Orders', 'view.medicines.orders', null),
(68, 'Create Medicines Orders', 'create.medicines.orders', 67),
(69, 'Edit Medicines Orders', 'edit.medicines.orders', 67),
(70, 'Toggle Medicines Orders', 'toggle.medicines.orders', 67),
(71, 'View Medicines Requests', 'view.medicines.requests', null),
(72, 'Create Medicines Requests', 'create.medicines.requests', 71),
(73, 'Edit Medicines Requests', 'edit.medicines.requests', 71),
(74, 'Approve Medicines Requests', 'approve.medicines.requests', 71),
(75, 'Dispense Medicines Requests', 'dispense.medicines.requests', 71),
(76, 'View Medicines Movement Report', 'view.medicines.movement', null),
(77, 'View Medicines Expiry Report', 'view.medicines.expiration', null),
(78, 'View Medicines Departments Request', 'view.medicines.departments.request', null);