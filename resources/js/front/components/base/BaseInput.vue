<template>
  <div class="form-group">
    <label :for="id" v-if="labelTxt">{{ labelTxt }}</label>
    <input
      :type="inputType"
      :id="id"
      :name="name"
      class="form-control"
      :class="{ 'is-invalid': inputErrors }"
      :placeholder="placeHolder"
      v-model.lazy="value"
    />
    <template v-if="inputErrors">
      <div
        class="invalid-feedback"
        v-for="(error, index) in inputErrors"
        :key="index"
        v-text="error"
      ></div>
    </template>
  </div>
</template>

<script>
import { computed, onBeforeMount, ref, toRefs } from "vue";
export default {
  props: {
    labelTxt: {
      type: String,
      required: false,
      default: null,
    },
    inputType: {
      type: String,
      required: false,
      default: "text",
    },
    index: {
      type: [Number, String],
      required: false,
      default: "",
    },
    name: String,
    id: {
      type: String,
      required: false,
    },
    value: String,
    placeHolder: {
      type: String,
      required: false,
      default: "",
    },
    errors: {
      type: [Object, String],
    },
  },
  setup(props, { emit }) {
    const { labelTxt, inputType, name, placeHolder } = toRefs(props);
    const id = ref("");
    const named = name.value + (props.index !== "" ? `.${props.index}` : "");

    onBeforeMount(() => {
      if (props.hasOwnProperty("id")) {
        id.value = props.id;
      } else {
        id.value = `${name.value.replace("_", "-")}${
          props.index !== "" ? `-${props.index + 1}` : ""
        }`;
      }
    });
    return {
      labelTxt,
      inputType,
      name,
      id,
      placeHolder,
      value: computed({
        get: () => props.value,
        set: (val) => {
          emit("update:value", val);
        },
      }),
      inputErrors: computed(() => {
        return props.errors != "" && props.errors.hasOwnProperty(named)
          ? props.errors[named]
          : false;
      }),
    };
  },
};
</script>

<style></style>
