<template>
  <div class="container my-4">
    <div class="row justify-content-center">
      <div class="col-sm-4 mx-auto">
        <div class="card">
          <div class="card-header">
            <h4 class="card-title">Register</h4>
          </div>
          <div class="card-body">
            <form @submit.prevent="tokenReq">
              <div class="form-group mb-2">
                <label for="name">Name</label>
                <input
                  type="text"
                  class="form-control"
                  :class="{ 'is-invalid': nameErrors }"
                  id="name"
                  name="name"
                  v-model.lazy="name"
                  placeholder="Name..."
                />
                <template v-if="nameErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in nameErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
              <div class="form-group mb-2">
                <label for="email">Email</label>
                <input
                  type="email"
                  class="form-control"
                  :class="{ 'is-invalid': emailErrors }"
                  id="email"
                  name="email"
                  v-model.lazy="email"
                  placeholder="Email Address..."
                />
                <template v-if="emailErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in emailErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
              <div class="form-group mb-2">
                <label for="password">Password</label>
                <input
                  type="password"
                  class="form-control"
                  :class="{ 'is-invalid': passwordErrors }"
                  id="password"
                  name="password"
                  v-model.lazy="password"
                  placeholder="Password..."
                />
                <template v-if="passwordErrors">
                  <div
                    class="invalid-feedback"
                    v-for="(error, index) in passwordErrors"
                    :key="index"
                    v-text="error"
                  ></div>
                </template>
              </div>
              <div class="form-group mb-2">
                <label for="confirm-password">Confirm Password</label>
                <input
                  type="password"
                  class="form-control"
                  id="confirm-password"
                  name="confirm-password"
                  v-model.lazy="cpassword"
                  placeholder="Password..."
                />
              </div>
              <div class="d-flex justify-content-between p-3">
                <button type="submit" class="btn btn-primary">Register</button>
                <router-link class="btn btn-secondary" to="/login">Login</router-link>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, reactive, toRefs } from "vue";
import { useStore } from "vuex";
import { useRouter } from "vue-router";
export default {
  setup() {
    const store = useStore();
    const router = useRouter();
    const state = reactive({
      name: "",
      email: "",
      password: "",
      cpassword: "",
    });
    async function tokenReq() {
      await axios.get("/sanctum/csrf-cookie").then((res) => {
        register();
      });
    }

    async function register() {
      store.dispatch("setLoading", true);
      const formData = new FormData();
      formData.append("name", state.name);
      formData.append("email", state.email);
      formData.append("password", state.password);
      formData.append("password_confirmation", state.cpassword);
      await axios
        .post("/api/v1/register", formData)
        .then((res) => {
          store.dispatch("setLoading", false);
          store.commit("setUserAndAuth", res.data.user);
          router.replace({ name: "panel" });
        })
        .catch((error) => {
          let errors = "";
          let code = 500;
          let message = "Server error";
          store.dispatch("setLoading", false);
          if (error.hasOwnProperty("response") && error.response.status == 422) {
            errors = error.response.data.errors;
            code = 422;
            message = "Invalid data given";
          }
          store.dispatch("setResponseWithErrors", {
            response: { message: message, code: code, status: "error" },
            errors: errors,
          });
        });
    }

    return {
      ...toRefs(state),
      tokenReq,
      isLoading: computed(() => store.getters.isLoading),
      hasResponse: computed(() => store.getters.hasResponse),
      getResponse: computed(() => store.getters.getResponse),
      nameErrors: computed(() =>
        store.getters.getErrors.hasOwnProperty("name")
          ? store.getters.getErrors.name
          : false
      ),
      emailErrors: computed(() =>
        store.getters.getErrors.hasOwnProperty("email")
          ? store.getters.getErrors.email
          : false
      ),
      passwordErrors: computed(() =>
        store.getters.getErrors.hasOwnProperty("password")
          ? store.getters.getErrors.password
          : false
      ),
    };
  },
};
</script>

<style></style>
