<template>
  <div class="app-content content mx-0">
    <div class="content-overlay"></div>
    <div class="content-wrapper">
      <div class="content-body">
        <section class="row flexbox-container">
          <div class="col-12 d-flex align-items-center justify-content-center">
            <div class="col-lg-4 col-md-8 col-10 box-shadow-2 p-0">
              <div class="card border-grey border-lighten-3 px-2 py-2 m-0">
                <div class="card-header border-0 pb-0">
                  <div class="card-title text-center">
                    <img
                      src="/temp/app-assets/images/logo/stack-logo-dark.png"
                      alt="branding logo"
                    />
                  </div>
                  <h6
                    class="card-subtitle line-on-side text-muted text-center font-small-3 pt-2"
                  >
                    <span>We will send you a link to reset password.</span>
                  </h6>
                </div>
                <div class="card-content">
                  <div class="card-body">
                    <form class="form-horizontal" @submit.prevent="emailToken">
                      <fieldset class="form-group position-relative has-icon-left">
                        <input
                          type="email"
                          class="form-control form-control-lg"
                          :class="{ 'is-invalid': emailErrors }"
                          id="email"
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
                        <div class="form-control-position">
                          <i class="feather icon-mail"></i>
                        </div>
                      </fieldset>
                      <button
                        type="submit"
                        class="btn btn-outline-primary btn-lg btn-block"
                        :disabled="isLoading"
                      >
                        <i class="feather icon-unlock"></i> Recover Password
                      </button>
                    </form>
                  </div>
                </div>
                <div class="card-footer border-0">
                  <p class="float-sm-left text-center">
                    <router-link class="card-link" to="/login">Login</router-link>
                  </p>
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
export default {
  setup() {
    const store = useStore();
    const email = ref("");

    async function emailToken() {
      store.dispatch("setLoading", true);
      const formData = new FormData();
      formData.append("email", email.value);
      await axios
        .post("/api/v1/forgot-password", formData)
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
      email,
      emailToken,
      isLoading: computed(() => store.getters.isLoading),
      hasResponse: computed(() => store.getters.hasResponse),
      getResponse: computed(() => store.getters.getResponse),
      emailErrors: computed(() =>
        store.getters.getErrors.hasOwnProperty("email")
          ? store.getters.getErrors.email
          : false
      ),
    };
  },
};
</script>

<style></style>
