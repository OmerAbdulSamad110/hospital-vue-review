import { createRouter, createWebHistory } from "vue-router";
// import Home from "../pages/Home";
import Panels from "../pages/Panels";

import AdminDashboard from "../pages/dashboards/Admin";
import InventoryDashboard from "../pages/dashboards/Inventory";
import EquipmentDashboard from "../pages/dashboards/Equipment";
import PharmacyDashboard from "../pages/dashboards/Pharmacy";

import Employees from "../pages/lists/Employees";
import Categories from "../pages/lists/Categories";
import Workshops from "../pages/lists/Workshops";
import Departments from "../pages/lists/Departments";
import Rooms from "../pages/lists/Rooms";
import Suppliers from "../pages/lists/suppliers/List";
import Engineers from "../pages/lists/suppliers/Engineers";
import Equipments from "../pages/lists/equipments/List";
import Medicines from "../pages/lists/medicines/List";
import MedicineInventory from "../pages/lists/medicines/Inventories";
import MedicinesOrders from "../pages/lists/medicines/Orders";
import MedicinesRequests from "../pages/lists/medicines/Requests";
import MedicinesMovements from "../pages/lists/medicines/reports/Movement";
import MedicinesRequestsReport from "../pages/lists/medicines/reports/Medicine";
import MedicinesDepartments from "../pages/lists/medicines/reports/Department";
import MedicinesExpirations from "../pages/lists/medicines/reports/Expiration";
import EquipmentShow from "../pages/lists/equipments/Show";
import Services from "../pages/lists/equipments/Services";
import Items from "../pages/lists/items/List";
import ItemQRs from "../pages/lists/items/QRs";
import Roles from "../pages/lists/Roles";
import Factories from "../pages/lists/Factories";
import Login from "../pages/auth/Login";
import Register from "../pages/auth/Register";
import Forget from "../pages/auth/password/Forget";
import Reset from "../pages/auth/password/Reset";
import ProfileEdit from "../pages/profile/Edit";
import AssignedItems from "../pages/lists/Assigned";
import NotFound from "../pages/errors/NotFound"
import UnAuthorize from "../pages/errors/UnAuthorize"

function prefixRoutes(prefix, routes) {
    return routes.map(route => ({
        ...route,
        name: prefix + "." + route.name,
        path: `/${prefix}/` + route.path,
        meta: { ...route.meta, auth: true },
        sensitive: true
    }))
}

const routes = [
    {
        path: "/",
        alias: "",
        name: "panel",
        component: Panels,
        meta: {
            auth: true,
        },
    },
    {
        path: "/profile/edit",
        name: "profile.edit",
        component: ProfileEdit,
        meta: {
            auth: true,
        },
    },
    {
        path: "/general",
        name: "general.home",
        component: AssignedItems,
        meta: {
            auth: true
        }
    },
    ...prefixRoutes("admin", [
        {
            path: "dashboard",
            name: "home",
            component: AdminDashboard,
        },
        {
            path: "emloyees",
            name: "employees",
            component: Employees,
            meta: {
                permission: "view.employees"
            }
        },
        {
            path: "categories/:type(main|sub)",
            name: "categories",
            component: Categories,
            props: true,
            meta: {
                permission: "view.categories"
            }
        },
        {
            path: "departments",
            name: "departments",
            component: Departments,
            meta: {
                permission: "view.departments"
            }
        },
        {
            path: "rooms",
            name: "rooms",
            component: Rooms,
            meta: {
                permission: "view.rooms"
            }
        },
        {
            path: "suppliers/:type(inventory|equipment|medicine)",
            name: "suppliers",
            component: Suppliers,
            props: true,
            meta: {
                permissions: {
                    inventory: "view.suppliers.inventory",
                    equipment: "view.suppliers.equipment",
                    medicine: "view.suppliers.medicine"
                }
            }
        },
        {
            path: "suppliers/:supplier(\\d+)/engineers",
            name: "suppliers.engineers",
            component: Engineers,
            meta: {
                permission: "view.equipment.supplier.engineers"
            }
        },
        {
            path: "items",
            name: "items",
            component: Items,
            meta: {
                permission: "view.items",
            },
        },
        {
            path: "items/:item(\\d+)/qrs",
            name: "item.qrs",
            component: ItemQRs,
            meta: {
                permission: "view.item.qrs",
            },
        },
        {
            path: "roles",
            name: "roles",
            component: Roles,
            meta: {
                permission: "view.roles",
            },
        },
        {
            path: "factories",
            name: "factories",
            component: Factories,
            meta: {
                permission: "view.factories",
            },
        }
    ]),
    ...prefixRoutes("inventory", [
        {
            path: "dashboard",
            name: "home",
            component: InventoryDashboard,
        },
        {
            path: "items",
            name: "items",
            component: Items,
            meta: {
                permission: "view.items",
            },
        },
        {
            path: "items/:item(\\d+)/qrs",
            name: "item.qrs",
            component: ItemQRs,
            meta: {
                permission: "view.item.qrs",
            },
        },
    ]),
    ...prefixRoutes("equipments", [
        {
            path: "dashboard",
            name: "home",
            component: EquipmentDashboard,
        },
        {
            path: "list",
            name: "list",
            component: Equipments,
            meta: {
                permission: "view.equipments",
            },
        },
        {
            path: ":equipment(\\d+)",
            name: "show",
            component: EquipmentShow,
            meta: {
                permission: "view.equipments.detail",
            },
        },
        {
            path: ":equipment(\\d+)/services",
            name: "services",
            component: Services,
            meta: {
                permission: "view.equipments.detail",
            },
        },
        {
            path: "suppliers",
            name: "suppliers",
            component: Suppliers,
            props: { type: "equipment" },
            meta: {
                permission: "view.suppliers.equipment",
            },
        },
        {
            path: "suppliers/:supplier(\\d+)/engineers",
            name: "suppliers.engineers",
            component: Engineers,
            meta: {
                permission: "view.equipment.supplier.engineers",
            },
        },
        {
            path: "workshops",
            name: "workshops",
            component: Workshops,
            meta: {
                permission: "view.workshops",
            },
        },
    ]),
    ...prefixRoutes("pharmacy", [
        {
            path: "dashboard",
            name: "home",
            component: PharmacyDashboard,
        },
        {
            path: "medicines",
            name: "medicines",
            component: Medicines,
            meta: {
                permission: "view.medicines",
            },
        },
        {
            path: "medicines/inventory",
            name: "medicines.inventory",
            component: MedicineInventory,
            meta: {
                permission: "view.medicines.inventories",
            },
        },
        {
            path: "medicines/orders",
            name: "medicines.orders",
            component: MedicinesOrders,
            meta: {
                permission: "view.medicines.orders",
            },
        },
        {
            path: "medicines/requests",
            name: "medicines.requests",
            component: MedicinesRequests,
            meta: {
                permission: "view.medicines.requests",
            },
        },
        {
            path: "reports/medicines/inventories/movement",
            name: "report.inventories.movement",
            component: MedicinesMovements,
            meta: {
                permission: "view.medicines.movement",
            },
        },
        {
            path: "reports/medicines/expirations",
            name: "report.expirations",
            component: MedicinesExpirations,
            meta: {
                permission: "view.medicines.expiration",
            },
        },
        // {
        //     path: "reports/medicines/requests",
        //     name: "report.requests",
        //     component: MedicinesRequestsReport,
        //     meta: {
        //         permission: "view.medicines.inventories",
        //     },
        // },
        {
            path: "reports/departments/medicines/requests",
            name: "report.departments.requests",
            component: MedicinesDepartments,
            meta: {
                permission: "view.medicines.departments.request",
            },
        }
    ]),
    {
        path: "/login",
        name: "login",
        component: Login,
        meta: {
            auth: false,
        },
    },
    {
        path: "/register",
        name: "register",
        component: Register,
        meta: {
            auth: false,
        },
    },
    {
        path: "/password/forget",
        name: "password.forget",
        component: Forget,
        meta: {
            auth: false,
        },
    },
    {
        path: "/password/reset/:token",
        name: "password.reset",
        component: Reset,
        meta: {
            auth: false,
        },
    },
    {
        path: "/error/403",
        name: "errors.403",
        component: UnAuthorize,
    },
    {
        path: "/error/404",
        name: "errors.404",
        component: NotFound,
    },
    {
        path: "/:pathMatch(.*)*",
        beforeEnter(to, from, next) {
            next({ name: "errors.404", replace: true })
        }
    }
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
