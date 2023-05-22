<template>
  <section>
    <BaseDataTables
      entity="item qr"
      :columns="[1, 2, 3, 4, 5, 6, 8, 9]"
      :objects="qrs"
      v-on="{
        ...(can('create.item.qrs') && {
          createEntity: () => onModalCall('create'),
        }),
      }"
      :extraOptions="{ columnDefs: [{ targets: 0, orderable: false }] }"
      :fetching="isFetching"
    >
      <template #header-buttons v-if="selectedQrCount > 0">
        <button type="button" class="btn btn-success ml-2" @click="getSelectedQrs">
          Get Qr{{ selectedQrCount > 1 ? "s" : "" }}
        </button>
      </template>
      <template #header-cols>
        <th>
          <div class="custom-control custom-checkbox text-center" v-show="qrsCount > 0">
            <input
              type="checkbox"
              class="custom-control-input"
              name="select_all"
              id="select-all"
              value="0"
              :checked="areAllQrSelected"
              @change="selectQrs"
            />
            <label class="custom-control-label" for="select-all"></label>
          </div>
        </th>
        <th>S.No</th>
        <th>Unique Value</th>
        <th>Department</th>
        <th>Supplier</th>
        <th>Assignment</th>
        <th>Purchased</th>
        <th>Key</th>
        <th>Qr</th>
        <th>Created</th>
        <th>Updated</th>
        <th>Actions</th>
      </template>
      <template v-slot:body-rows="slotProps">
        <tr v-for="(qr, index) in qrs" :key="qr.id">
          <td>
            <div class="custom-control custom-checkbox text-center">
              <input
                type="checkbox"
                class="custom-control-input"
                :name="`select_${qr.id}`"
                :id="`select-${qr.id}`"
                :value="qr.id"
                v-model.number="selectedQrs"
              />
              <label class="custom-control-label" :for="`select-${qr.id}`"></label>
            </div>
          </td>
          <td>{{ index + 1 }}</td>
          <td>{{ qr.unique_value }}</td>
          <td>{{ qr.department.title }}</td>
          <td>{{ qr.supplier.name }}</td>
          <td v-if="qr.assign_info != null" v-html="setAssignView(qr.assign_info)"></td>
          <td v-else>Unassigned</td>
          <td>{{ qr.purchased_at }}</td>
          <td>{{ `${qr.unique_value}-${qr.id}` }}</td>
          <td>
            <button type="button" class="btn btn-sm btn-info" @click="viewItemQr(qr.id)">
              <i class="fas fa-qrcode text-white"></i>
            </button>
          </td>
          <td>{{ slotProps.setZone(qr.created_at) }}</td>
          <td>{{ slotProps.setZone(qr.updated_at) }}</td>
          <td>
            <div class="d-flex justify-content-around align-items-center">
              <button
                type="button"
                class="btn btn-sm btn-primary"
                @click="onModalCall('update', { id: qr.id })"
                v-if="can('edit.item.qrs')"
              >
                <i class="fa fa-pencil-square-o"></i>
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
      :confirmBtnReq="['update', 'create'].includes(mode) ? true : false"
      :scrollable="itemCount > 3"
      v-if="can(['create.item.qrs', 'edit.item.qrs'])"
    >
      <template #header>
        <span class="text-capitalize">{{ mode }} QR{{ itemCount > 1 ? "s" : null }}</span>
      </template>
      <template #body>
        <template v-if="['update', 'create'].includes(mode)">
          <div class="row">
            <div class="col-sm-6">
              <div class="form-group">
                <label for="type">Type</label>
                <select
                  id="type"
                  class="custom-select text-capitalize"
                  @change="
                    () => {
                      supplierId = '';
                    }
                  "
                  v-model="selectedSupLocale"
                >
                  <option :value="index" v-for="(locale, index) in locales" :key="index">
                    {{ locale }}
                  </option>
                </select>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="supplier">Supplier</label>
                <select
                  id="supplier"
                  class="custom-select text-capitalize"
                  :class="{ 'is-invalid': !!supplierErrors }"
                  v-model="supplierId"
                >
                  <template v-if="setSuppliers.length > 0">
                    <option
                      class="text-capitalize"
                      v-for="supplier in setSuppliers"
                      :key="supplier.id"
                      :value="supplier.id"
                    >
                      {{ supplier.name }}
                    </option>
                  </template>
                  <option value="" disabled v-else>No Suppliers</option>
                </select>
                <template v-if="!!supplierErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in supplierErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="department">Department</label>
                <select
                  id="department"
                  class="custom-select text-capitalize"
                  :class="{ 'is-invalid': !!departmentErrors }"
                  v-model="selectedDept"
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
                <template v-if="!!departmentErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in departmentErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="form-group">
                <label for="purchase">Purchase Date</label>
                <input
                  type="date"
                  id="purchase"
                  class="form-control"
                  :class="{ 'is-invalid': !!purchasedErrors }"
                  v-model.lazy="purchased_at"
                />
                <template v-if="!!purchasedErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in purchasedErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
            </div>
          </div>
          <div class="form-group" v-if="mode == 'create'">
            <label for="quantity">Qr Quantity</label>
            <div class="input-group">
              <input
                type="number"
                id="quantity"
                class="form-control"
                v-model.lazy="quantity"
                min="1"
              />
              <div class="input-group-append">
                <button
                  type="button"
                  class="btn btn-danger btn-sm"
                  @click="generateItemQrs"
                >
                  Change
                </button>
              </div>
            </div>
          </div>
          <div class="overflow-auto">
            <BaseInput
              v-for="(_, index) in unique_values"
              :key="index"
              v-bind="dynamicProps(index, `Item #${index + 1}`)"
              place-holder="Enter unique value like modal no etc..."
              v-model:value="unique_values[index]"
              :errors="uniqueValueErrors"
            />
          </div>
        </template>
        <QrcodeVue
          class="w-100"
          :value="qrData"
          :size="350"
          level="H"
          v-else-if="mode == 'view' && qrData != ''"
        />
      </template>
    </BaseModal>
  </section>
</template>

<script>
import { computed, inject, onBeforeMount, reactive, toRefs, watch } from "vue";
import { useRoute } from "vue-router";
import BaseInput from "../../../components/base/BaseInput.vue";
import BaseModal from "../../../components/base/BaseModal.vue";
import QrcodeVue from "qrcode.vue";
import BaseDataTables from "../../../components/base/BaseDataTables.vue";
import usePromise from "../../../hooks/usePromise";

export default {
  components: { BaseInput, BaseModal, QrcodeVue, BaseDataTables },
  setup() {
    const { result, errors, loading, fetching, createPromise } = usePromise();
    const route = useRoute();
    const locales = ["Local", "International", "City"];
    const state = reactive({
      showModal: false,
      mode: "",
      item: route.params.item,
      qrs: [],
      departments: [],
      suppliers: [],
      selectedDept: "",
      selectedSupLocale: 0,
      supplierId: "",
      selectedId: "",
      qrData: "",
      unique_values: [""],
      quantity: 1,
      selectedQrs: [],
      purchased_at: "",
    });
    onBeforeMount(() => {
      createPromise(`items/${state.item}/itemQrs`);
    });

    function selectQrs(e) {
      const isChecked = e.target.checked;
      let temp = [];
      if (isChecked) {
        temp = state.qrs.map((qr) => qr.id);
      }
      state.selectedQrs = temp;
    }

    function getSelectedQrs() {
      const formData = new FormData();
      state.selectedQrs.forEach((qr) => {
        formData.append("qrs[]", qr);
      });
      createPromise("generate/qrs", {
        method: "POST",
        data: formData,
        responseType: "blob",
      });
    }

    function generateItemQrs() {
      const count = state.quantity > 1 ? state.quantity : 1;
      const len = state.unique_values.length;
      if (count > len) {
        for (let i = 0; i < count - len; i++) {
          state.unique_values.push("");
        }
      } else if (count < len) {
        state.unique_values.length = count;
      }
    }

    function viewItemQr(id) {
      state.mode = "view";
      const temp = state.qrs.find((qr) => qr.id == id);
      state.qrData = temp.unique_value + "-" + temp.id;
      state.showModal = true;
    }

    function onModalCall(mode, data = "") {
      if (mode == "update") {
        const temp = state.qrs.find((qr) => qr.id == data.id);
        state.selectedSupLocale = locales.indexOf(temp.supplier.locale);
        state.supplierId = temp.supplier.id;
        state.purchased_at = temp.purchased_at.split("-").reverse().join("-");
        state.unique_values[0] = temp.unique_value;
        state.selectedId = data.id;
      }
      state.mode = mode;
      state.showModal = true;
    }

    function onConfirmModal() {
      const formData = new FormData();
      let url = `items/${state.item}/itemQrs`;
      formData.append("department", state.selectedDept);
      formData.append("supplier", state.supplierId);
      formData.append("purchased_at", state.purchased_at);
      if (state.mode == "create") {
        state.unique_values.forEach((unique) => {
          formData.append("unique_values[]", unique);
        });
      } else {
        formData.append("unique_value", state.unique_values[0]);
        formData.append("_method", "PUT");
        url = `itemQrs/${state.selectedId}`;
      }
      createPromise(url, {
        method: "POST",
        data: formData,
      });
    }

    function onCloseModal() {
      state.showModal = false;
      if (["update", "create"].includes(state.mode)) {
        state.selectedSupLocale = 0;
        state.purchased_at = "";
        state.unique_values = [""];
        if (state.mode == "create") {
          state.quantity = 1;
        }
      }
      state.mode = "";
      state.selectedId = "";
    }

    function setAssignView(assign) {
      return `<div class="text-wrap">
        <div class="font-weight-bold">Assignor:</div>${assign.assignor.name}, ${assign.assignor.email}
        </div>
        <div class="text-wrap">
        <div class="font-weight-bold">Assignee:</div>${assign.assignee.name}, ${assign.assignee.email}
        </div>
        <div class="text-wrap">
        <div class="font-weight-bold">Assigned Date:</div>${assign.assigned_date}
        </div>`;
    }

    watch(
      result,
      (newVal) => {
        if (
          newVal.hasOwnProperty("qrs") &&
          newVal.hasOwnProperty("departments") &&
          newVal.hasOwnProperty("suppliers")
        ) {
          state.qrs = newVal.qrs;
          state.suppliers = newVal.suppliers;
          state.departments = newVal.departments;
          state.selectedDept = newVal.departments[0].id;
        } else if (newVal.hasOwnProperty("qrs")) {
          state.qrs = [...newVal.qrs, ...state.qrs];
        } else if (state.mode == "update") {
          const temp = state.qrs.find((qr) => qr.id == state.selectedId);
          if (state.supplierId != temp.supplier.id) {
            const supp = state.suppliers.find((sup) => sup.id == state.supplierId);
            temp.supplier = { ...supp };
          }
          if (state.selectedDept != temp.department.id) {
            const dept = state.departments.find((dept) => dept.id == state.selectedDept);
            temp.department = { ...dept };
          }
          temp.purchased_at = state.purchased_at.split("-").reverse().join("-");
          temp.unique_value = state.unique_values[0];
          temp.updated_at = new Date().toISOString();
        }
        // if (newVal.hasOwnProperty("headers")) {
        //   console.log("here");
        //     const data = result.value.data;
        //     const headers = result.value.headers;
        //     const url = window.URL.createObjectURL(new Blob([data]));
        //     const link = document.createElement("a");
        //     link.href = url;
        //     link.setAttribute(
        //       "download",
        //       headers["content-disposition"].split("filename=")[1]
        //     );
        //     document.body.appendChild(link);
        //     link.click();
        //     document.body.removeChild(link);
        //     state.selectedQrs = [];
        // }
        if (!!state.mode && !!newVal) {
          onCloseModal();
        }
      },
      {
        immediate: false,
      }
    );

    return {
      ...toRefs(state),
      setSuppliers: computed(() => {
        const suppliers = state.suppliers.filter(
          (supplier) => supplier.locale == locales[state.selectedSupLocale]
        );
        if (suppliers.length > 0) {
          state.supplierId = state.selectedSupId || suppliers[0].id;
        }
        return suppliers;
      }),
      locales,
      itemCount: computed(() => state.unique_values.length),
      onModalCall,
      onConfirmModal,
      onCloseModal,

      setAssignView,
      generateItemQrs,
      dynamicProps: (index = null, label = null) => {
        if (state.mode == "create") {
          return {
            "label-txt": label,
            index: index,
            name: "unique_values",
          };
        } else if (state.mode == "update") {
          return {
            "label-txt": "Unique Value",
            name: "unique_value",
          };
        }
      },
      viewItemQr,

      selectQrs,
      selectedQrCount: computed(() => state.selectedQrs.length),
      areAllQrSelected: computed(() => state.selectedQrs.length == state.qrs.length),
      getSelectedQrs,

      isLoading: computed(() => loading.value),
      isFetching: computed(() => fetching.value),
      uniqueValueErrors: computed(() => errors.value.unique_values || ""),
      departmentErrors: computed(() => errors.value.department || false),
      supplierErrors: computed(() => errors.value.supplier || false),
      purchasedErrors: computed(() => errors.value.purchased_at || false),
      qrsCount: computed(() => state.qrs.length),

      can: inject("can"),
    };
  },
};
</script>

<style>
.text-white {
  color: white !important;
}
</style>
