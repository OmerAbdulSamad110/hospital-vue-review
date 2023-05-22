<template>
  <section>
    <BaseDataTables
      entity="item"
      :columns="[0, 1, 2, 3, 4, 5, 7, 8]"
      :objects="items"
      v-on="{
        ...(can('create.items') && { createEntity: () => onModalCall('create') }),
      }"
      :fetching="isFetching"
    >
      <template #header-buttons v-if="can('toggle.items.assign')">
        <button
          type="button"
          class="btn btn-success ml-2"
          @click="onModalCall('toggleAssign')"
        >
          Assign/Unassign Item
        </button>
      </template>
      <template #header-cols>
        <th>S.No</th>
        <th>Name</th>
        <th>Description</th>
        <th>Main Category</th>
        <th>Sub Category</th>
        <th>Factory</th>
        <th>Add Qrs</th>
        <th>Created</th>
        <th>Updated</th>
        <th v-if="can(['edit.items', 'toggle.items', 'view.item.qrs'])">Actions</th>
      </template>

      <template v-slot:body-rows="slotProps">
        <tr
          :class="{ 'inactive-row': !item.status }"
          v-for="(item, index) in items"
          :key="item.id"
        >
          <td>{{ index + 1 }}</td>
          <td>{{ item.name }}</td>
          <td>{{ item.description }}</td>
          <td>{{ item.sub_category.main_category.name }}</td>
          <td>{{ item.sub_category.name }}</td>
          <td>{{ item.factory.name }}</td>
          <td>
            <router-link
              class="btn btn-sm btn-success"
              :to="{
                name: `${getPanel}.item.qrs`,
                params: { item: item.id },
              }"
              v-if="can('view.item.qrs')"
            >
              <i class="fas fa-qrcode"></i>
            </router-link>
          </td>
          <td>{{ slotProps.setZone(item.created_at) }}</td>
          <td>{{ slotProps.setZone(item.updated_at) }}</td>
          <td
            :data-order="item.status"
            v-if="can(['edit.items', 'toggle.items', 'view.item.qrs'])"
          >
            <div class="d-flex justify-content-around align-items-center">
              <button
                type="button"
                class="btn btn-sm btn-primary"
                @click="onModalCall('update', { id: item.id })"
                v-if="can('edit.items')"
              >
                <i class="fa fa-pencil-square-o"></i>
              </button>
              <button
                type="button"
                class="btn btn-sm"
                :class="toggleClasses(item.status)[0]"
                @click="
                  onModalCall('toggle', {
                    id: item.id,
                    status: item.status,
                  })
                "
                v-if="can('toggle.items')"
              >
                <i class="fa" :class="toggleClasses(item.status)[1]"></i>
              </button>
            </div>
          </td>
        </tr>
      </template>
    </BaseDataTables>
    <BaseModal
      :show="showModal"
      @close="onCloseModal"
      @confirm="onConfirmModal"
      :loading="isLoading"
      :confirmBtnTxt="setConfirmBtnTxt()"
      :confirmBtnReq="mode == 'toggleAssign' && !qr ? false : true"
      :scrollable="mode == 'toggleAssign' && !!qr"
      v-if="can(['create.items', 'edit.items', 'toggle.items', 'toggle.items.assign'])"
    >
      <template #header>
        <span class="text-capitalize">{{ mode }} Item</span>
      </template>
      <template #body>
        <template v-if="['update', 'create'].includes(mode)">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label for="name">Name</label>
                <input
                  type="text"
                  class="form-control"
                  :class="{ 'is-invalid': !!nameErrors }"
                  v-model.lazy="itemData.name"
                  id="name"
                  placeholder="Item name..."
                />
                <template v-if="!!nameErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in nameErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="factory">Factory</label>
                <select
                  class="custom-select text-capitalize"
                  :class="{ 'is-invalid': !!factoryErrors }"
                  id="factory"
                  v-model="itemData.factory"
                >
                  <option
                    class="text-capitalize"
                    v-for="factory in factories"
                    :key="factory.id"
                    :value="factory.id"
                  >
                    {{ factory.name }}
                  </option>
                </select>
                <template v-if="!!factoryErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in factoryErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="main">Main Category</label>
                <select
                  class="custom-select text-capitalize"
                  id="main"
                  v-model="itemData.main"
                  @change="
                    () => {
                      selectedSC = '';
                    }
                  "
                >
                  <option
                    class="text-capitalize"
                    v-for="main in mains"
                    :key="main.id"
                    :value="main.id"
                  >
                    {{ main.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="sub">Sub Category</label>
                <select
                  class="custom-select text-capitalize"
                  :class="{ 'is-invalid': !!subErrors }"
                  id="sub"
                  v-model="itemData.sub"
                >
                  <option
                    class="text-capitalize"
                    v-for="sub in subs"
                    :key="sub.id"
                    :value="sub.id"
                  >
                    {{ sub.name }}
                  </option>
                </select>
                <template v-if="!!subErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in subErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
          </div>
          <div class="form-group">
            <label for="description">Description</label>
            <input
              type="text"
              class="form-control"
              :class="{ 'is-invalid': !!descriptionErrors }"
              v-model.lazy="itemData.description"
              id="description"
              placeholder="Item description..."
            />
            <template v-if="!!descriptionErrors">
              <div
                class="invalid-feedback"
                v-for="(error, index) in descriptionErrors"
                :key="index"
                v-text="error"
              ></div>
            </template>
          </div>
        </template>
        <div class="container mt-0" v-else-if="mode == 'toggleAssign'">
          <template v-if="!assignMode">
            <button
              type="button"
              class="btn btn-primary btn-block mb-2"
              @click="changeAssignMode('qr')"
            >
              Scan Qr
            </button>

            <h4 style="font-size: 1.74rem; text-align: center">Or</h4>
            <button
              type="button"
              class="btn btn-primary btn-block mt-2"
              @click="changeAssignMode('input')"
            >
              Enter Code
            </button>
          </template>
          <template v-else>
            <QrStream
              @decode="decodeQr"
              :class="{ 'is-invalid error-border': !!qrError }"
              v-if="assignMode == 'qr'"
            ></QrStream>
            <div
              class="d-flex align-items-center"
              :class="{ 'is-invalid error-border': !!qrError }"
              v-else
            >
              <input
                type="text"
                class="form-control"
                id="code"
                name="code"
                placeholder="Enter Code..."
                v-model="code"
              />
              <button type="button" class="btn btn-info ml-1" @click="decodeQr">
                Enter
              </button>
            </div>
          </template>
          <template v-if="!!qrError">
            <div class="text-center text-danger h5 mb-0" v-text="qrError[0]"></div>
          </template>
          <div class="row" v-if="qr">
            <div class="col-6">
              <div class="form-group">
                <label>Unique Value</label>
                <input
                  type="text"
                  class="form-control"
                  :value="qr.unique_value"
                  readonly
                />
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label>Item</label>
                <input type="text" class="form-control" :value="qr.item.name" readonly />
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label>Main Category</label>
                <input
                  type="text"
                  class="form-control"
                  :value="qr.item.sub_category.main_category.name"
                  readonly
                />
              </div>
            </div>
            <div class="col-6">
              <div class="form-group">
                <label>Sub Category</label>
                <input
                  type="text"
                  class="form-control"
                  :value="qr.item.sub_category.name"
                  readonly
                />
              </div>
            </div>
            <template v-if="qrData.isAssign">
              <div class="col-6">
                <div class="form-group">
                  <label>Assigned Date</label>
                  <input
                    type="text"
                    class="form-control"
                    :value="qr.assign_info.assigned_date"
                    readonly
                  />
                </div>
              </div>
              <div class="col-6">
                <div class="form-group">
                  <label>Assignor</label>
                  <input
                    type="text"
                    class="form-control"
                    :value="
                      qr.assign_info.assignor.name + ', ' + qr.assign_info.assignor.email
                    "
                    readonly
                  />
                </div>
              </div>
            </template>
            <div class="col-md-12 col-12">
              <div class="form-group">
                <label for="department">Department</label>
                <select
                  class="custom-select text-capitalize"
                  id="department"
                  v-model="qrData.department"
                  @change="fetchEmployees"
                  :disabled="!!qrData.isAssign"
                >
                  <option
                    class="text-capitalize"
                    v-for="department in departments"
                    :key="department.id"
                    :value="department.id"
                  >
                    {{ department.title }}
                  </option>
                </select>
              </div>
            </div>
            <div class="col-md-12 col-12">
              <div class="form-group">
                <label for="empoyee">Assignee</label>
                <select
                  class="custom-select w-100"
                  :class="{ 'is-invalid': !!employeeErrors }"
                  id="empoyee"
                  v-model="qrData.employee"
                  :disabled="!!qrData.isAssign"
                >
                  <option
                    class="text-capitalize"
                    v-for="employee in employees"
                    :key="employee.id"
                    :value="employee.id"
                  >
                    {{ employee.name }}, {{ employee.email }}
                  </option>
                </select>
                <template v-if="!!employeeErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in employeeErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
          </div>
        </div>
        <p v-else>{{ bodyTxt }}</p>
      </template>
    </BaseModal>
  </section>
</template>

<script>
import { computed, inject, onBeforeMount, reactive, toRefs, watch } from "vue";
import BaseModal from "../../../components/base/BaseModal.vue";
import { QrStream } from "vue3-qr-reader";
import BaseDataTables from "../../../components/base/BaseDataTables.vue";
import usePromise from "../../../hooks/usePromise";

export default {
  components: { BaseModal, QrStream, BaseDataTables },
  setup() {
    const { result, errors, loading, fetching, createPromise } = usePromise();
    const state = reactive({
      getPanel: inject("panel"),
      showModal: false,
      mode: "",
      bodyTxt: "",
      items: [],
      factories: [],
      departments: [],
      mains: [],
      selectedId: "",
      itemData: {
        name: "",
        description: "",
        main: "",
        sub: "",
        factory: "",
      },
      qr: "",
      qrData: {
        isAssign: false,
        department: "",
        employee: "",
      },
      employees: [],
      selectedSC: "",
      subs: computed(() => {
        if (state.mains.length > 0 && state.itemData.main != "") {
          const subs = state.mains.find((main) => main.id == state.itemData.main)
            .sub_categories;
          state.itemData.sub = state.selectedSC || subs[0].id;
          return subs;
        }
        return [];
      }),

      assignMode: "",
      code: "",
    });

    onBeforeMount(() => {
      createPromise("items");
    });

    function toggleClasses(status) {
      return !status ? ["btn-danger", "fa-toggle-off"] : ["btn-success", "fa-toggle-on"];
    }

    function decodeQr(str = "") {
      if (!!str && state.assignMode == "qr") {
        readQrData(str);
      } else if (!!state.code && state.assignMode == "input") {
        readQrData(state.code);
      }
    }

    function readQrData(str) {
      const formData = new FormData();
      formData.append("code", str);
      createPromise("item/qr/read", {
        method: "POST",
        data: formData,
      });
    }

    function onModalCall(mode, data = "") {
      if (mode == "update") {
        const item = state.items.find((item) => item.id == data.id);
        Object.keys(state.itemData).forEach((key) => {
          if (key == "main") {
            state.itemData[key] = item["sub_category"].main_category.id;
          } else if (key == "sub") {
            state.selectedSC = state.itemData[key] = item["sub_category"].id;
          } else if (key == "factory") {
            state.factory = state.itemData[key] = item["factory"].id;
          } else {
            state.itemData[key] = item[key];
          }
        });
        state.selectedId = data.id;
      } else if (mode == "toggle") {
        state.selectedId = data.id;
        state.mode = "toggle";
        state.bodyTxt = `Are you sure you want to ${
          data.status ? "deactive" : "activate"
        } this item`;
      }
      state.mode = mode;
      state.showModal = true;
    }

    function onConfirmModal() {
      const formData = new FormData();
      let url = "items";
      if (["create", "update"].includes(state.mode)) {
        Object.keys(state.itemData).forEach((key) => {
          if (key != "main") {
            let temp = key;
            if (key == "sub") {
              temp = "sub_category";
            }
            formData.append(temp, state.itemData[key]);
          }
        });
        if (state.mode == "update") {
          formData.append("_method", "PUT");
          url = `items/${state.selectedId}`;
        }
      } else if (state.mode == "toggleAssign") {
        formData.append("employee", state.qrData.employee);
        formData.append("_method", "PUT");
        url = `itemQrs/${state.qr.id}/assignment/toggle`;
      } else if (state.mode == "toggle") {
        formData.append("_method", "PUT");
        url = `items/${state.selectedId}/toggle`;
      }
      createPromise(url, {
        method: "POST",
        data: formData,
      });
    }

    function onCloseModal() {
      state.showModal = false;
      if (["update", "create"].includes(state.mode)) {
        if (state.selectedSC != "") {
          state.selectedSC = "";
        }
        Object.keys(state.itemData).some((key) => {
          if (key == "main" && !!state.mains[0]) {
            state.itemData[key] = state.mains[0].id;
          } else if (key == "sub" && !!state.subs[0]) {
            state.itemData[key] = state.subs[0].id;
          } else if (key == "factory" && !!state.factories[0]) {
            state.itemData[key] = state.factories[0].id;
          } else {
            state.itemData[key] = "";
          }
        });
      } else if (state.mode == "toggleAssign") {
        resetQrData();
        state.assignMode = "";
        state.code = "";
      }
      state.mode = "";
      state.selectedId = "";
    }

    function resetQrData() {
      state.qr = "";
      state.employees = [];
      for (const key in state.qrData) {
        state.qrData[key] =
          key != "isAssign"
            ? key == "department" && !!state.departments[0]
              ? state.departments[0].id
              : ""
            : false;
      }
    }

    function fetchEmployees() {
      createPromise(`departments/${state.qrData.department}/employees`);
    }

    function changeAssignMode(mode) {
      state.assignMode = mode;
    }

    watch(
      () => state.qr,
      (newVal, oldVal) => {
        if (newVal != "" && newVal != oldVal) {
          const assign = newVal.assign_info;
          if (assign) {
            state.qrData.department = assign.assignee.department.id;
            state.qrData.employee = assign.assignee.id;
            state.qrData.isAssign = true;
          }
          if (state.employees.length < 1) {
            fetchEmployees();
          }
        }
      },
      {
        deep: true,
      }
    );

    watch(
      result,
      (newVal) => {
        if (
          newVal.hasOwnProperty("items") &&
          newVal.hasOwnProperty("departments") &&
          newVal.hasOwnProperty("mains") &&
          newVal.hasOwnProperty("factories")
        ) {
          state.items = newVal.items;
          state.departments = newVal.departments;
          state.mains = newVal.mains;
          state.factories = newVal.factories;
          if (newVal.departments.length > 0) {
            state.qrData.department = newVal.departments[0].id;
          }
          if (newVal.mains.length > 0) {
            state.itemData.main = newVal.mains[0].id;
          }
          if (newVal.factories.length > 0) {
            state.itemData.factory = newVal.factories[0].id;
          }
        } else if (newVal.hasOwnProperty("item")) {
          state.items = [newVal.item, ...state.items];
        } else if (newVal.hasOwnProperty("employees")) {
          state.employees = newVal.employees;
          if (!state.isAssign) {
            state.qrData.employee = state.employees[0].id;
          }
        } else if (newVal.hasOwnProperty("qr")) {
          state.qr = {
            ...newVal.qr,
            item: state.items.find((item) => item.id == newVal.qr.item),
          };
        } else if (["update", "toggle"].includes(state.mode)) {
          const item = state.items.find((item) => item.id == state.selectedId);
          if (state.mode == "update") {
            Object.entries(state.itemData).forEach(([key, value]) => {
              if (key != "main" && key != "sub" && key != "factory") {
                item[key] = value;
              } else if (key == "sub" && item["sub_category"].id != value) {
                item["sub_category"] = {
                  ...state.subs.find((sc) => sc.id == value),
                  main_category: {
                    ...state.mains.find((mc) => mc.id == state.itemData.main),
                  },
                };
              } else if (key == "factory" && item["factory"].id != value) {
                item["factory"] = state.factories.find((fac) => fac.id == value);
              }
            });
          } else {
            item.status = !item.status;
          }
          item.updated_at = new Date().toISOString();
        }
        if (
          !!state.mode &&
          (state.mode != "toggleAssign" || newVal.hasOwnProperty("assignment"))
        ) {
          onCloseModal();
        }
      },
      {
        immediate: false,
      }
    );

    return {
      ...toRefs(state),
      toggleClasses,
      onModalCall,
      onConfirmModal,
      onCloseModal,
      decodeQr,
      setConfirmBtnTxt: () =>
        state.mode != "toggleAssign"
          ? "confirm"
          : state.qr && state.qr.assign_info
          ? "Unassign"
          : "Assign",

      fetchEmployees,
      changeAssignMode,
      isLoading: computed(() => loading.value),
      isFetching: computed(() => fetching.value),
      nameErrors: computed(() => errors.value.name || false),
      descriptionErrors: computed(() => errors.value.description || false),
      subErrors: computed(() => errors.value.sub_category || false),
      factoryErrors: computed(() => errors.value.factory || false),
      qrError: computed(() => errors.value.code || false),
      employeeErrors: computed(() => errors.value.employee || false),

      can: inject("can"),
    };
  },
};
</script>

<style scoped>
.error-border {
  border: solid red 0.5px !important;
}
.success-border {
  border: solid green 0.5px !important;
}
.qr-stream-wrapper {
  width: 15.65rem !important;
  height: 15.65rem !important;
  margin: auto;
}
</style>
