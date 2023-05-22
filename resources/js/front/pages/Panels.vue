<template>
  <div class="container">
    <div class="card card-body">
      <div
        class="row"
        :class="{ 'justify-content-start': panels.length > 1 }"
        v-if="panelLoaded"
      >
        <div class="col-md-6 my-2" v-for="(panel, index) in panels" :key="index">
          <router-link
            class="btn btn-block btn-success text-white slide hvr-grow"
            :to="{ name: panel.url }"
          >
            <i :class="setIcons(panel.url)"></i>
            {{ panel.title }}
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, ref } from "vue";
import { useStore } from "vuex";
export default {
  setup() {
    const store = useStore();
    const panels = ref(store.getters.getPanels);
    const icons = {
      admin: "fas fa-user-cog",
      inventory: "fas fa-boxes",
      default: " fas fa-cog",
    };
    function setIcons(link) {
      const title = link.split(".")[0];
      return icons.hasOwnProperty(title) ? icons[title] : icons["default"];
    }

    return {
      panels,
      panelLoaded: computed(() => panels.value.length > 0),
      setIcons,
    };
  },
};
</script>

<style>
.container {
  margin-top: 10%;
}
a.btn.btn-block.btn-success.text-white {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  font-size: 25px;
  background-color: transparent !important;
  border: 0;
  color: #223a66 !important;
  font-weight: 700;
  width: 80%;
  margin: 0 auto;
}

a.btn.btn-block.btn-success.text-white:hover {
  /* background: rgb(34,58,102);
    background: linear-gradient(90deg, rgba(34,58,102,1) 0%, rgba(28,186,159,1) 100%, rgba(34,58,102,1) 100%); */
  color: #fff !important;
}

.hvr-grow {
  display: inline-block;
  vertical-align: middle;
  transform: translateZ(0);
  box-shadow: 0 0 1px rgba(0, 0, 0, 0);
  backface-visibility: hidden;
  -moz-osx-font-smoothing: grayscale;
  transition-duration: 0.3s;
  transition-property: transform;
}

.hvr-grow:hover,
.hvr-grow:focus,
.hvr-grow:active {
  transform: scale(1.1);
}
.slide {
  position: relative;
  overflow: hidden;
}
.slide::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 145%;
  height: 100%;
  transform: translate(-110%, 0) skew(-30deg);
  transition: 0.5s;
  background: rgb(34, 58, 102);
  background: linear-gradient(
    90deg,
    rgba(34, 58, 102, 1) 0%,
    rgba(28, 186, 159, 1) 100%,
    rgba(34, 58, 102, 1) 100%
  );
  z-index: -9;
}
.slide:hover::before {
  transform: translate(-5%, 0) skew(-15deg);
}

a.btn.btn-block.btn-success.text-white i.fas {
  padding-bottom: 20px;
}
/* body {
    background: rgb(28,185,158);
    background: radial-gradient(circle, rgba(28,185,158,1) 0%, rgba(34,58,102,1) 100%);
} */
</style>
