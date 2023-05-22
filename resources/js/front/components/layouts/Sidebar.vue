<template>
  <SidebarMenu
    :menu="menu"
    width="240px"
    widthCollapsed="60px"
    :hideToggle="true"
    theme="white-theme"
  />
</template>

<script>
import { computed, inject, toRef } from "vue";
import { SidebarMenu } from "vue-sidebar-menu";
import "../../styles/sidebar.css";

export default {
  components: {
    SidebarMenu,
  },
  props: {
    panelType: String,
  },
  setup(props) {
    const type = toRef(props, "panelType");
    const can = inject("can");
    const isSuper = inject("isSuper");
    function havePerm(menu) {
      const temp = menu.permission;
      delete menu.permission;
      return can(temp);
    }
    const menuByType = {
      general: [
        {
          title: "Assigned Items",
          href: { name: "general.home" },
          icon: "fas fa-box",
        },
      ],
      admin: [
        {
          title: "Dashboard",
          href: { name: "admin.home" },
          icon: "fas fa-home",
        },
        {
          title: "Employees",
          href: { name: "admin.employees" },
          icon: "fas fa-user-tie",
          permission: "view.employees",
        },
        {
          title: "Categories",
          icon: "fas fa-layer-group",
          child: [
            {
              title: "Main",
              href: { name: "admin.categories", params: { type: "main" } },
              icon: "far fa-compass",
            },
            {
              title: "Sub",
              href: { name: "admin.categories", params: { type: "sub" } },
              icon: "fas fa-code-branch",
            },
          ],
          permission: "view.categories",
        },
        {
          title: "Department",
          href: { name: "admin.departments" },
          icon: "far fa-building",
          permission: "view.departments",
        },
        {
          title: "Rooms",
          href: { name: "admin.rooms" },
          icon: "fas fa-cube",
          permission: "view.rooms",
        },
        {
          title: "Suppliers",
          icon: "fas fa-user",
          child: [
            {
              title: "Inventory",
              href: { name: "admin.suppliers", params: { type: "inventory" } },
              icon: "far fa-compass",
              permission: "view.suppliers.inventory",
            },
            {
              title: "Equipment",
              href: { name: "admin.suppliers", params: { type: "equipment" } },
              icon: "fas fa-code-branch",
              permission: "view.suppliers.equipment",
            },
            {
              title: "Medicine",
              href: { name: "admin.suppliers", params: { type: "medicine" } },
              icon: "fas fa-pills",
              permission: "view.suppliers.medicine",
            },
          ],
        },
        {
          title: "Items",
          icon: "fas fa-box",
          href: { name: "admin.items" },
          permission: "view.items",
        },
        {
          title: "Roles",
          icon: "fas fa-gavel",
          href: { name: "admin.roles" },
          permission: "view.roles",
        },
        {
          title: "Factories",
          icon: "fas fa-industry",
          href: { name: "admin.factories" },
          permission: "view.factories",
        },
      ],
      inventory: [
        {
          title: "Dashboard",
          href: { name: "inventory.home" },
          icon: "fas fa-home",
        },
        {
          title: "Items",
          icon: "fas fa-box",
          href: { name: "inventory.items" },
          permission: "view.items",
        },
      ],
      equipments: [
        {
          title: "Dashboard",
          href: { name: "equipments.home" },
          icon: "fas fa-home",
        },
        {
          title: "Equipments",
          icon: "fas fa-industry",
          href: { name: "equipments.list" },
          permission: "view.equipments",
        },
        {
          title: "Suppliers",
          href: { name: "equipments.suppliers", params: { type: "equipment" } },
          icon: "fas fa-code-branch",
          permission: "view.suppliers.equipment",
        },
        {
          title: "Workshops",
          href: { name: "equipments.workshops" },
          icon: "fas fa-home",
          permission: "view.workshops",
        },
      ],
      pharmacy: [
        {
          title: "Dashboard",
          href: { name: "pharmacy.home" },
          icon: "fas fa-home",
        },
        {
          title: "Medicines",
          icon: "fas fa-pills",
          child: [
            {
              title: "List",
              href: { name: "pharmacy.medicines" },
              icon: "fas fa-clipboard-list",
              permission: "view.medicines",
            },
            {
              title: "Inventory",
              href: { name: "pharmacy.medicines.inventory" },
              icon: "fas fa-prescription-bottle",
              permission: "view.medicines.inventories",
            },
            {
              title: "Orders",
              href: { name: "pharmacy.medicines.orders" },
              icon: "far fa-box",
              permission: "view.medicines.orders",
            },
            {
              title: "Requests",
              href: { name: "pharmacy.medicines.requests" },
              icon: "far fa-comment-medical",
              permission: "view.medicines.requests",
            },
          ],
        },
        {
          title: "Reports",
          icon: "fas fa-clipboard-list",
          child: [
            {
              title: "Inventory Movement",
              href: { name: "pharmacy.report.inventories.movement" },
              icon: "fas fa-arrow-to-right",
              permission: "view.medicines.movement",
            },
            {
              title: "Medicines Expirations",
              href: { name: "pharmacy.report.expirations" },
              icon: "far fa-calendar-times",
              permission: "view.medicines.expiration",
            },
            // {
            //   title: "Medicines Requests",
            //   href: { name: "pharmacy.report.requests" },
            //   icon: "far fa-comment-medical",
            // },
            {
              title: "Department Requests",
              href: { name: "pharmacy.report.departments.requests" },
              icon: "fas fa-building",
              permission: "view.medicines.departments.requests",
            },
          ],
        },
      ],
    };

    function filteredMenu() {
      if (!isSuper) {
        return menuByType[type.value].filter((menu) => {
          if (!menu.permission) {
            if (!!menu.child) {
              menu.child = menu.child.filter((child) => havePerm(child));
              return menu.child.length > 0;
            }
            return true;
          } else if (!!menu.permission && havePerm(menu)) {
            return true;
          }
          return false;
        });
      } else {
        return menuByType[type.value];
      }
    }
    return {
      menu: computed(() => [
        {
          header: "",
          hiddenOnCollapse: true,
        },
        ...(filteredMenu() || menuByType["general"]),
      ]),
    };
  },
};
</script>

<style scoped>
.v-sidebar-menu {
  top: 4rem;
}

.v-sidebar-menu.vsm_expanded li.vsm--item:hover {
  box-shadow: 0 2.8px 2.2px rgb(0 0 0 / 3%), 0 6.7px 5.3px rgb(0 0 0 / 5%),
    0 12.5px 10px rgb(0 0 0 / 6%), 0 22.3px 17.9px rgb(0 0 0 / 7%),
    0 41.8px 33.4px rgb(0 0 0 / 9%), 0 100px 80px rgb(0 0 0 / 12%) !important;
}
.v-sidebar-menu .vsm--link_level-1 i {
  background-color: transparent !important;
  background: transparent !important;
}
.vsm--dropdown {
  background-color: transparent !important;
  display: none !important;
}

.v-sidebar-menu .vsm--link_level-1.vsm--link_active {
  background-color: #3e4046bf !important;
  box-shadow: inset 3px 0 0 0 #fff !important;
}

.v-sidebar-menu .vsm--link_active,
.v-sidebar-menu .vsm--link_open {
  background: red !important;
}
</style>
