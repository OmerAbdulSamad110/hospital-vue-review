<template>
  <div>
    <div class="modal-backdrop fade show" v-if="showModal" @click="$emit('close')"></div>
    <teleport to="body">
      <div class="modal fade" :class="[showModal ? ['show', 'show-modal'] : '']">
        <div
          class="modal-dialog modal-dialog-centered"
          :class="[{ 'modal-dialog-scrollable': isScrollable }, { 'modal-lg': large }]"
        >
          <div class="modal-content">
            <div class="modal-header">
              <h2 class="modal-title"><slot name="header">Title</slot></h2>
              <button type="button" class="btn btn-light" @click="$emit('close')">
                <i class="fa fa-times"></i>
              </button>
            </div>
            <div class="modal-body">
              <slot name="body"></slot>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" @click="$emit('close')">
                {{ closeBtnTxt }}
              </button>
              <slot name="footer-btn" v-if="confirmBtnReq">
                <button
                  type="button"
                  class="btn btn-primary text-capitalize"
                  @click="$emit('confirm')"
                  :disabled="isLoading"
                >
                  {{ confirmBtnTxt }}
                </button>
              </slot>
            </div>
          </div>
        </div>
      </div>
    </teleport>
  </div>
</template>

<script>
import { computed, toRefs } from "vue";
export default {
  props: {
    show: Boolean,
    confirmBtnReq: {
      type: Boolean,
      required: false,
      default: true,
    },
    closeBtnTxt: {
      type: String,
      required: false,
      default: "Close",
    },
    confirmBtnTxt: {
      type: String,
      required: false,
      default: "Confirm",
    },
    scrollable: {
      type: Boolean,
      required: false,
      default: false,
    },
    large: {
      type: Boolean,
      required: false,
      default: false,
    },
    loading: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
  setup(props) {
    const { closeBtnTxt, confirmBtnTxt, large } = toRefs(props);
    return {
      isLoading: computed(() => props.loading),
      confirmBtnReq: computed(() => props.confirmBtnReq),
      closeBtnTxt,
      confirmBtnTxt,
      showModal: computed(() => props.show),
      isScrollable: computed(() => props.scrollable),
    };
  },
};
</script>

<style scoped>
.show-modal {
  display: block;
  padding-right: 17px;
}
</style>
