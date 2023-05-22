<template>
  <div v-if="!!response">
    <teleport to="body">
      <div class="toast mx-2" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header h6 mb-0" :class="property(response.status, 1)">
          <i :class="property(response.status, 0)"></i>
          <div class="mx-2 w-100">
            <strong class="text-capitalize">{{ response.status }}</strong>
          </div>
          <button
            type="button"
            class="close"
            data-dismiss="toast"
            aria-label="Close"
            @click="closeFlash"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="toast-body">{{ response.message }}</div>
      </div>
    </teleport>
  </div>
</template>

<script>
import { computed, watch } from "vue";
import { useStore } from "vuex";
export default {
  setup() {
    const store = useStore();
    const response = computed(() => store.getters.getResponse);
    function property(status, index) {
      const pro = {
        success: ["fa fa-check", "text-success"],
        error: ["fas fa-times-circle", "text-danger"],
        warning: ["fas fa-exclamation-triangle", "text-warning"],
      };
      return pro[status][index];
    }

    function closeFlash() {
      store.dispatch("setResponseAction");
    }

    watch(
      response,
      (newVal) => {
        if (!!newVal) {
          setTimeout(() => closeFlash(), 5000);
        }
      },
      {
        immediate: false,
      }
    );
    return {
      response,
      property,
      closeFlash,
    };
  },
};
</script>

<style scoped>
.toast {
  display: block;
  opacity: 1 !important;
  position: fixed;
  top: 17rem;
  left: 40%;
  min-width: 30rem !important;
  min-height: 10rem !important;
  z-index: 1090;
}
.toast-body {
  font-size: 1.5rem;
  text-align: center;
}
.toast-header {
  font-size: 1.2rem;
}
</style>
