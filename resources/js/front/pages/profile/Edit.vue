<template>
  <div class="container">
    <div class="row">
      <div class="col-md-12 pb-1">
        <h4>
          <router-link to="/">
            <i class="fas fa-home"></i> Back to Panels</router-link
          >
        </h4>
      </div>
    </div>

    <div class="card card-body">
      <div class="row">
        <div class="col-sm-3">
          <div
            class="nav flex-column nav-pills"
            id="v-pills-tab"
            role="tablist"
            aria-orientation="vertical"
          >
            <a
              class="nav-link active"
              id="v-pills-info-tab"
              data-toggle="pill"
              href="#v-pills-info"
              role="tab"
              aria-controls="v-pills-info"
              aria-selected="true"
              >Profile Info</a
            >
          </div>
        </div>
        <div class="col-sm-7">
          <div class="tab-content" id="v-pills-tabContent">
            <div
              class="tab-pane fade show active"
              id="v-pills-info"
              role="tabpanel"
              aria-labelledby="v-pills-info-tab"
            >
              <form @submit.prevent="changeProfileData">
                <div class="text-center mb-2">
                  <div
                    class="image-container"
                    :class="{ 'is-invalid': !!pictureErrors }"
                  >
                    <img
                      :src="setImage"
                      alt="profile-picture"
                      class="image"
                      width="150"
                      height="150"
                    />
                    <div
                      class="middle"
                      :class="{
                        'w-100 d-flex justify-content-between px-1': hasFile,
                      }"
                    >
                      <button
                        type="button"
                        class="btn btn-primary btn-sm"
                        @click="onFileClick"
                      >
                        Change
                      </button>
                      <button
                        type="button"
                        class="btn btn-danger btn-sm"
                        @click="onFileRevert"
                        v-show="hasFile"
                      >
                        Revert
                      </button>
                    </div>
                    <input
                      type="file"
                      id="change-pic"
                      class="d-none"
                      ref="file"
                      @change="onFileUpload"
                    />
                  </div>
                  <template v-if="!!pictureErrors">
                    <div
                      class="invalid-feedback"
                      v-for="(error, index) in pictureErrors"
                      :key="index"
                      v-text="error"
                    ></div>
                  </template>
                </div>
                <div class="form-group mb-2">
                  <label for="name">Name:</label>
                  <input
                    type="text"
                    id="name"
                    class="form-control"
                    :class="{ 'is-invalid': !!nameErrors }"
                    placeholder="Enter Name..."
                    v-model.lazy="profile.name"
                  />
                  <template v-if="!!nameErrors">
                    <div
                      class="invalid-feedback"
                      v-for="(error, index) in nameErrors"
                      :key="index"
                      v-text="error"
                    ></div>
                  </template>
                </div>
                <div class="form-group mb-2">
                  <label for="email">Email:</label>
                  <input
                    type="email"
                    id="email"
                    class="form-control"
                    :class="{ 'is-invalid': !!emailErrors }"
                    placeholder="Enter Email..."
                    v-model.lazy="profile.email"
                  />
                  <template v-if="!!emailErrors">
                    <div
                      class="invalid-feedback"
                      v-for="(error, index) in emailErrors"
                      :key="index"
                      v-text="error"
                    ></div>
                  </template>
                </div>
                <div class="form-group mb-2">
                  <label for="phone">Phone:</label>
                  <input
                    type="tel"
                    id="phone"
                    class="form-control"
                    :class="{ 'is-invalid': !!phoneErrors }"
                    placeholder="Enter Phone..."
                    v-model.lazy="profile.phone"
                  />
                  <template v-if="!!phoneErrors">
                    <div
                      class="invalid-feedback"
                      v-for="(error, index) in phoneErrors"
                      :key="index"
                      v-text="error"
                    ></div>
                  </template>
                </div>
                <div
                  class="form-group mb-2"
                  v-if="profile.hasOwnProperty('number')"
                >
                  <label for="number">Number:</label>
                  <input
                    type="text"
                    id="number"
                    class="form-control"
                    :class="{ 'is-invalid': !!numberErrors }"
                    placeholder="Enter Id Number..."
                    v-model.lazy="profile.number"
                  />
                  <template v-if="!!numberErrors">
                    <div
                      class="invalid-feedback"
                      v-for="(error, index) in numberErrors"
                      :key="index"
                      v-text="error"
                    ></div>
                  </template>
                </div>
                <button
                  type="submit"
                  class="btn btn-success btn-block mb-2"
                  :disabled="isLoading"
                >
                  Update
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed, onBeforeMount, ref } from "vue";
import { useStore } from "vuex";
import usePromise from "../../hooks/usePromise";

export default {
  setup() {
    const store = useStore();
    const { errors, loading, createPromise } = usePromise();
    const employee = store.getters.user.employee;
    const profile = ref({
      picture: employee.picture,
      name: employee.name,
      email: employee.email,
      phone: employee.phone,
    });
    const image = ref("");
    const setImage = computed(() =>
      image.value ? URL.createObjectURL(image.value) : profile.value.picture
    );
    const file = ref(null);

    onBeforeMount(() => {
      if (employee.role.name == "super admin") {
        profile.value["number"] = employee.number;
      }
    });

    function onFileUpload(event) {
      if (event.target.files.length > 0) {
        const file = event.target.files[0];
        image.value = file;
      }
    }

    async function changeProfileData() {
      const formData = new FormData();
      Object.keys(profile.value).some((key) => {
        if (key == "picture") {
          formData.append(key, image.value);
        } else {
          formData.append(key, profile.value[key]);
        }
      });
      formData.append("_method", "PUT");
      await createPromise(`employees/${employee.id}`, {
        method: "POST",
        data: formData,
      });
      if (!loading.value) {
        if (!!image.value) {
          profile.value.picture = setImage.value;
          image.value = "";
        }
        store.commit("updateProfile", profile.value);
      }
    }

    return {
      profile,
      setImage,
      hasFile: computed(() => image.value != ""),
      onFileUpload,
      onFileClick: () => file.value.click(),
      onFileRevert: () => (image.value = ""),
      changeProfileData,
      file,

      isLoading: computed(() => loading.value),

      nameErrors: computed(() => errors.value.name || false),
      emailErrors: computed(() => errors.value.email || false),
      phoneErrors: computed(() => errors.value.phone || false),
      numberErrors: computed(() => errors.value.number || false),
      pictureErrors: computed(() => errors.value.picture || false),
    };
  },
};
</script>

<style scoped>
form {
  width: 45%;
  margin: 0 auto;
}

img {
  cursor: pointer;
}

.image-container {
  position: relative;
  display: inline-block;
}

.image {
  opacity: 1;
  transition: 0.5s ease;
  backface-visibility: hidden;
}

.middle {
  transition: 0.5s ease;
  opacity: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}

.image-container:hover .image {
  opacity: 0.3;
}

.image-container:hover .middle {
  opacity: 1;
}
</style>
