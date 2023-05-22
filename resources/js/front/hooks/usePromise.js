import { ref, watch } from "vue";
import store from "../store";
import router from "../router";
import axios from "axios";

const Axios = axios.create({
    withCredentials: true,
    headers: {
        common: { "X-Requested-With": "XMLHttpRequest" },
    },
});
const reqInterceptor = Axios.interceptors.request.use((request) => {
    return request;
});

const resInterceptor = Axios.interceptors.response.use(
    undefined,
    function (error) {
        if (error.hasOwnProperty("response")) {
            if (error.response.status == 401 || error.response.status == 419) {
                router.replace({ name: "login" });
                store.commit("setUserAuthPermission", "");
                console.clear()
            } else if (error.response.status == 404) {
                router.replace({ name: "errors.404" });
            } else if (error.response.status == 403) {
                router.replace({ name: "errors.404" });
            }
        }
        return Promise.reject(error);
    }
);

watch(
    () => [reqInterceptor, resInterceptor],
    (newVal) => {
        axios.interceptors.request.eject(newVal[0]);
        axios.interceptors.response.eject(newVal[1]);
    }
);

export default function usePromise() {
    const result = ref("")
    const errors = ref("")
    const loading = ref(false)
    const fetching = ref(true)

    async function createPromise(url, args = {}) {
        try {
            Axios.defaults.baseURL = "/api/v1/";
            if (args.hasOwnProperty("base")) {
                Axios.defaults.baseURL = "/";
                delete args["base"]
            }
            if (args.hasOwnProperty("wait")) {
                delete args["wait"]
            }
            if (!args.hasOwnProperty("loading") && !loading.value) {
                loading.value = true
            }
            errors.value = ""
            store.dispatch("setResponseAction")
            const response = await Axios(url, { ...args })
            result.value = response.data
            if (!!result.value && result.value.hasOwnProperty("message")) {
                store.dispatch("setResponseAction", {
                    message: result.value.message,
                    code: 200,
                    status: "success",
                })
            }
        } catch (e) {
            if (e.hasOwnProperty("response")) {
                if (e.response.status == 422) {
                    errors.value = e.response.data.errors
                    store.dispatch("setResponseAction", {
                        message: "Invalid data given",
                        code: 422,
                        status: "warning",
                    })
                } else if (e.response.status == 500) {
                    store.dispatch("setResponseAction", {
                        message: "Server error",
                        code: 500,
                        status: "error",
                    })
                }
            } else {
                console.log(e, e.response);
            }
        } finally {
            if (!args.hasOwnProperty("loading")) {
                fetching.value = false;
                loading.value = false;
            }
        }
    }

    function setErrors(key, e, remove) {
        errors.value[key] = e
        delete errors.value[remove]
    }

    return { result, errors, loading, fetching, createPromise, setErrors }
}
