<template>
  <div class="app-content content m-0">
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
                      src="/temp/app-assets/images/logo/stack-logo-dark.png"
                      alt="branding logo"
                    />
                  </div>
                </div>
                <div class="card-content">
                  <div class="card-body">
                    <form class="form-horizontal" @submit.prevent="reset">
                      <fieldset class="form-group position-relative has-icon-left">
                        <input
                          type="text"
                          class="form-control"
                          :class="{ 'is-invalid': emailErrors }"
                          id="email"
                          placeholder="Email address..."
                          v-model.lazy="email"
                        />
                        <template v-if="emailErrors">
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
                      <fieldset class="form-group position-relative has-icon-left">
                        <input
                          type="password"
                          class="form-control"
                          :class="{ 'is-invalid': passwordErrors }"
                          id="password"
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
                        <div class="form-control-position">
                          <i class="fa fa-key"></i>
                        </div>
                      </fieldset>
                      <fieldset class="form-group position-relative has-icon-left">
                        <input
                          type="password"
                          class="form-control"
                          id="confirm-password"
                          v-model.lazy="cpassword"
                          placeholder="Confirm Password..."
                        />

                        <div class="form-control-position">
                          <i class="fa fa-key"></i>
                        </div>
                      </fieldset>
                      <button
                        type="submit"
                        class="btn btn-outline-primary btn-block"
                        :disabled="isLoading"
                      >
                        <i class="fas fa-edit"></i> Reset Password
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
import { computed, reactive, toRefs } from "vue";
import { useRoute } from "vue-router";
import { useStore } from "vuex";
export default {
  setup() {
    const store = useStore();
    const route = useRoute();
    const state = reactive({
      email: route.query.email,
      token: route.params.token,
      password: "",
      cpassword: "",
    });

    async function reset() {
      store.dispatch("setLoading", true);
      const formData = new FormData();
      formData.append("email", state.email);
      formData.append("token", state.token);
      formData.append("password", state.password);
      formData.append("password_confirmation", state.cpassword);
      await axios
        .post("/api/v1/reset-password", formData)
        .then((res) => {
          store.dispatch("setLoading", false);
          console.log(res);
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
      reset,
      isLoading: computed(() => store.getters.isLoading),
      hasResponse: computed(() => store.getters.hasResponse),
      getResponse: computed(() => store.getters.getResponse),
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
