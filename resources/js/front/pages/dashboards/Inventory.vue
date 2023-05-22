<template>
  <section v-if="!isFetching">
    <div class="row">
      <div class="col-xl-3 col-lg-6 col-12">
        <div class="card">
          <router-link :to="{ name: 'inventory.items' }">
            <div class="card-content">
              <div class="card-body">
                <div class="media">
                  <div class="media-body text-left w-100">
                    <h3 class="primary">
                      {{ data["items"]["assigned"] + data["items"]["unassigned"] }}
                    </h3>
                    <span>Item Qrs</span>
                  </div>
                  <div class="media-right media-middle">
                    <i class="icon-globe primary font-large-2 float-right"></i>
                  </div>
                </div>
              </div>
            </div>
          </router-link>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <Doughnut
          class="card card-body"
          title="Items"
          :labels="['Assigned Items', 'Unassigned Items']"
          :data="[data.items.assigned, data.items.unassigned]"
        />
      </div>
    </div>
  </section>
</template>

<script>
import { computed, onBeforeMount, ref, watch } from "vue";
import Doughnut from "../../components/charts/Doughnut.vue";
import usePromise from "../../hooks/usePromise";

export default {
  components: { Doughnut },
  setup() {
    const { result, fetching, createPromise } = usePromise();
    const data = ref("");

    onBeforeMount(() => {
      createPromise("dashboard/inventory");
    });

    watch(result, (newVal) => {
      if (typeof newVal.hasOwnProperty("counts")) {
        data.value = newVal.counts;
      }
    });
    return {
      data,
      isFetching: computed(() => fetching.value),
    };
  },
};
</script>

<style></style>
