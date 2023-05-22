require("./bootstrap");
import { createApp } from "vue";
import RootApp from "./front/App";
import router from "./front/router";
import store from "./front/store";

const el = document.getElementById("app");
const user = el.dataset.user;
delete el.dataset.user;

store.dispatch("getUser", user).then((_) => {
    router.beforeEach((to, from, next) => {
        if (to.meta.hasOwnProperty("auth")) {
            if (to.meta.auth) {
                if (store.getters.isAuth) {
                    if (store.getters.isSuper) {
                        next();
                    } else if (!!to.meta.permission || !!to.meta.permissions) {
                        if (store.getters.can(to.meta.permission || to.meta.permissions[to.params.type])) {
                            next();
                        } else {
                            return next({ name: "errors.403", replace: true })
                        }
                    } else {
                        next();
                    }
                } else {
                    next({ name: "login", replace: true });
                }
            } else {
                if (!store.getters.isAuth) {
                    next();
                } else {
                    next({ name: "panel", replace: true });
                }
            }
        } else {
            next();
        }
    });

    createApp(RootApp).use(router).use(store).mount("#app");
});
