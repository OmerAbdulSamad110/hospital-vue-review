<template>
  <section>
    <Sidebar :panel-type="panel" />
    <div class="app-content content">
      <div class="content-overlay"></div>
      <div class="content-wrapper">
        <div class="content-body">
          <div class="container mt-2">
            <router-view />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { provide } from "vue";
import Sidebar from "../components/layouts/Sidebar.vue";
export default {
  name: "Home",
  components: { Sidebar },
  props: {
    panelType: String,
  },
  setup(props) {
    provide("panel", props.panelType);
    return {
      panel: props.panelType,
    };
  },
};
</script>

<style></style>
