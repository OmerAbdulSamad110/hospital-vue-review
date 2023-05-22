import usePromise from "../hooks/usePromise";
const { createStore } = require("vuex");
const store = createStore({
    state: {
        auth: false,
        user: "",
        permissions: [],
        response: "",
        loading: false,
        panels: [],
    },
    getters: {
        isAuth: (state) => state.user != "" && state.auth,
        user: (state) => state.user,
        isSuper: (state) => state.user.employee.role_id == 1,
        getPermissions: (state) => state.permissions,
        can: (state, getters) => (per, all = false) => {
            if (!getters.isAuth) {
                return false
            }
            if (!getters.isSuper) {
                if (typeof per == "string") {
                    return state.permissions.includes(per);
                } else if (typeof per != "string") {
                    if (all) {
                        return state.permissions.every(p => state.permissions.includes(p))
                    }
                    return state.permissions.some(p => state.permissions.includes(p))
                }
                return false
            }
            return true
        },
        getResponse: (state) => state.response,
        isLoading: (state) => state.loading,
        getPanels: (state) => state.panels,
        getPanelSlugs: (state) => {
            let slugs = [];
            if (state.panels.length > 0) {
                slugs = state.panels.map((panel) => panel.url.split(".")[0]);
            }
            return slugs;
        },
    },
    mutations: {
        setResponse(state, response) {
            state.response = response;
        },
        setLoading(state, loading) {
            state.loading = loading;
        },
        setUserAuthPermission(state, user) {
            if (user) {
                user.employee.picture =
                    user.employee.picture || "/images/dp.png";
                state.permissions = user.permissions.map((perm) => perm.slug);
                delete user.permissions;
            } else {
                state.permissions = [];
            }
            state.user = user;
            state.auth = user != "";
        },
        setPanels(state, panels) {
            state.panels = [
                { title: "General", url: "general.home" },
                ...panels,
            ];
        },
        updateProfile(state, profile) {
            Object.keys(profile).some((key) => {
                state.user.employee[key] = profile[key];
            });
        },
    },
    actions: {
        setResponseAction({ commit }, response = "") {
            commit("setResponse", response);
        },
        setLoading({ commit }, loading) {
            commit("setLoading", loading);
        },
        async getUser({ commit }, user) {
            if (user) {
                if (typeof user == "string") {
                    user = JSON.parse(user);
                }
                const { result, createPromise } = usePromise()
                await createPromise("panels");
                if (result.value.hasOwnProperty("panels")) {
                    commit("setPanels", result.value.panels);
                }
            }
            commit("setUserAuthPermission", user);
        },
        logoutUser({ commit }) {
            commit("setUserAuthPermission", "");
        },
    },
});

export default store;
