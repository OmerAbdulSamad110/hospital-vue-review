<template>
  <main>
    <Header
      :user="{ name: user.employee.name, picture: user.employee.picture }"
      :panel-type="panel"
      @onLogout="logout"
      v-if="auth"
    />
    <main :class="{ mt10: auth }">
      <Home :panel-type="panel" v-if="panel != ''" />
      <router-view v-else />
    </main>
    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>
    <BaseFlash />
  </main>
</template>

<script>
import { computed, provide, ref, watch } from "vue";
import { useStore } from "vuex";
import { useRoute, useRouter } from "vue-router";
import Header from "./components/layouts/Header";
import Footer from "./components/layouts/Footer";
import Home from "./pages/Home.vue";
import usePromise from "./hooks/usePromise";
import BaseFlash from "./components/base/BaseFlash.vue";

export default {
  components: { Header, Home, Footer, BaseFlash },
  name: "App",
  setup() {
    const store = useStore();
    const router = useRouter();
    const route = useRoute();
    const panel = ref("");
    const slugs = computed(() => store.getters.getPanelSlugs);
    const { loading, createPromise } = usePromise();

    provide("can", (p, all = true) => store.getters.can(p, all));
    provide("isSuper", store.getters.isAuth && store.getters.isSuper);

    async function logout() {
      await createPromise("logout", { method: "POST" });
      if (!loading.value) {
        store.dispatch("logoutUser");
        router.replace({ name: "login" });
      }
    }
    watch(
      () => route.name,
      (to, _) => {
        if (
          to != undefined &&
          /^\w*(\w+\.)+\w+$/.test(to) &&
          slugs.value.length > 0
        ) {
          const temp = to.split(".")[0];
          if (slugs.value.includes(temp)) {
            if (panel.value == "" || panel.value != temp) {
              panel.value = temp;
            }
          } else {
            panel.value = "";
          }
        } else if (panel.value != "") {
          panel.value = "";
        }
      },
      {
        deep: true,
      }
    );
    return {
      auth: computed(() => store.getters.isAuth),
      user: computed(() => store.getters.user),
      logout,
      panel,
    };
  },
};
</script>

<style>
.pointer {
  cursor: pointer;
}
.mt10 {
  margin-top: 5%;
}
</style>
