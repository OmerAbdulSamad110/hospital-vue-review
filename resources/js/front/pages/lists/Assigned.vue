<template>
  <section>
    <BaseDataTables
      entity="assigned item"
      :columns="[0, 1, 2, 3, 4]"
      :objects="assigns"
      :fetching="isFetching"
    >
      <template #header-cols>
        <th>S.No</th>
        <th>Item</th>
        <th>Department</th>
        <th>Assignor</th>
        <th>Date</th>
      </template>

      <template v-slot:body-rows="slotProps">
        <tr v-for="(assign, index) in assigns" :key="assign.id">
          <td>{{ index + 1 }}</td>
          <td>{{ assign.item.name }}</td>
          <td>{{ assign.department.title }}</td>
          <td>{{ assign.assign_info.assignor.name }}</td>
          <td>{{ slotProps.setZone(assign.assign_info.assigned_date) }}</td>
        </tr>
      </template>
    </BaseDataTables>
  </section>
</template>

<script>
import { computed, onBeforeMount, ref } from "vue";
import usePromise from "../../hooks/usePromise";
import BaseDataTables from "../../components/base/BaseDataTables.vue";

export default {
  components: { BaseDataTables },
  setup() {
    const { result, fetching, createPromise } = usePromise();
    const assigns = ref([]);

    onBeforeMount(async () => {
      await createPromise("assigned/items");
      if (!fetching.value) {
        assigns.value = result.value.assigns;
      }
    });

    return {
      assigns,
      isFetching: computed(() => fetching.value),
    };
  },
};
</script>
