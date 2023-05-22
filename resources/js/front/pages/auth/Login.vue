<template>
  <div class="app-content content m-0" id="login">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
      <div class="content-body">
        <section class="row flexbox-container">
          <div class="col-12 d-flex align-items-center justify-content-center">
            <div class="col-lg-4 col-md-8 col-10 box-shadow-2 p-0">
              <div class="card border-grey border-lighten-3 px-1 py-1 m-0">
                <div class="card-header border-0">
                  <div class="card-title text-center">
                    <img
                      src="/images/logo.png"
                      alt="branding logo"
                      class="logo"
                    />
                  </div>
                </div>
                <div class="card-content">
                  <div class="card-body">
                    <form class="form-horizontal" @submit.prevent="login">
                      <fieldset
                        class="form-group position-relative has-icon-left"
                      >
                        <input
                          type="text"
                          class="form-control"
                          :class="{ 'is-invalid': !!emailErrors }"
                          id="email"
                          placeholder="Email address..."
                          v-model.lazy="email"
                        />
                        <template v-if="!!emailErrors">
                          <div
                            class="invalid-feedback"
                            v-for="(error, index) in emailErrors"
                            :key="index"
                            v-text="error"
                          ></div>
                        </template>
                        <div class="form-control-position">
                          <i class="feather icon-user"></i>
                        </div>
                      </fieldset>
                      <fieldset
                        class="form-group position-relative has-icon-left"
                      >
                        <input
                          type="password"
                          class="form-control"
                          :class="{
                            'is-invalid': !!emailErrors || !!passwordErrors,
                          }"
                          id="password"
                          v-model.lazy="password"
                          placeholder="Password..."
                        />
                        <template v-if="!!passwordErrors">
                          <div
                            class="invalid-feedback"
                            v-for="(error, index) in passwordErrors"
                            :key="index"
                            v-text="error"
                          ></div>
                        </template>
                        <div class="form-control-position">
                          <i class="fa fa-key"></i>
                        </div>
                      </fieldset>
                      <div
                        class="
                          d-flex
                          justify-content-between
                          align-items-center
                          my-2
                        "
                      >
                        <div class="form-group form-check mb-0">
                          <input
                            type="checkbox"
                            class="form-check-input"
                            id="remember"
                            v-model="remember"
                          />
                          <label class="form-check-label" for="remember"
                            >Remember Me</label
                          >
                        </div>
                        <router-link class="card-link" to="/password/forget"
                          >Forgot Password?</router-link
                        >
                      </div>
                      <button
                        type="submit"
                        class="btn btn-outline-primary btn-block global-btn"
                        :disabled="isLoading"
                      >
                        <i class="feather icon-unlock"></i> Login
                      </button>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, ref } from "vue";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
import usePromise from "../../hooks/usePromise";
export default {
  setup() {
    const store = useStore();
    const router = useRouter();
    const { result, errors, loading, createPromise } = usePromise();
    const email = ref("");
    const password = ref("");
    const remember = ref(0);

    async function login() {
      const formData = new FormData();
      formData.append("email", email.value);
      formData.append("password", password.value);
      formData.append("remember", remember.value);
      await createPromise("sanctum/csrf-cookie", {
        base: false,
        loading: false,
      }).then(async () => {
        await createPromise("login", { method: "POST", data: formData });
        if (result.value.hasOwnProperty("user")) {
          await store.dispatch("getUser", result.value.user).then((_) => {
            router.replace({ name: "panel" });
          });
        }
      });
    }

    return {
      email,
      password,
      remember,
      login,
      isLoading: computed(() => loading.value),
      emailErrors: computed(() => errors.value.email || false),
      passwordErrors: computed(() => errors.value.password || false),
    };
  },
};
</script>

<style>
div#login {
  background-image: url(/images/main.jpg);
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  height: 100vh;
}
body {
  padding: 0 !important;
}
.global-btn {
  background-color: #1cba9f;
  border: none;
  font-weight: bold;
  box-shadow: none;
  color: #fff;
}
.global-btn:hover {
  background-color: #223a66 !important;
}
.global-a {
  color: #1cba9f;
}
.global-a:hover {
  color: #223a66;
}
.logo {
  width: 100%;
}
#login .has-icon-left i {
  position: relative;
  color: #fff;
  font-size: 16px;
}

#login .has-icon-left i:after {
  content: "";
  position: absolute;
  background-color: #223a66;
  width: 35px;
  height: 40px;
  left: -8px;
  top: -13px;
  z-index: -9;
}
</style>
