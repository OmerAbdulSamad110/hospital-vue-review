<template>
  <nav
    class="header-navbar navbar-expand-md navbar navbar-with-menu fixed-top navbar-dark bg-gradient-x-primary navbar-shadow"
  >
    <div class="navbar-wrapper">
      <div class="navbar-header">
        <ul class="nav navbar-nav flex-row">
          <li class="nav-item mobile-menu d-md-none mr-auto">
            <a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"
              ><i class="feather icon-menu font-large-1"></i
            ></a>
          </li>
          <li class="nav-item">
            <router-link
              class="navbar-brand"
              :to="{ name: !!type ? `${type}.home` : 'panel' }"
            >
              <img class="brand-logo" alt="stack admin logo" src="/images/logo.png" />
            </router-link>
          </li>
          <li class="nav-item d-md-none">
            <a
              class="nav-link open-navbar-container"
              data-toggle="collapse"
              data-target="#navbar-mobile"
              ><i class="fa fa-ellipsis-v"></i
            ></a>
          </li>
        </ul>
      </div>
      <div class="navbar-container content">
        <div class="collapse navbar-collapse" id="navbar-mobile">
          <ul class="nav navbar-nav mx-auto">
            <li class="nav-item d-none d-md-block">
              <h4 class="nav-link hidden-xs mb-0 font-weight-bold text-capitalize">
                {{ !type ? "Panels" : type + " Panel" }}
              </h4>
            </li>
          </ul>
          <ul class="nav navbar-nav float-right">
            <li class="nav-item mx-2">
              <router-link class="nav-link" :to="{ name: 'panel' }">Panels</router-link>
            </li>
            <li class="dropdown dropdown-user nav-item">
              <a
                class="dropdown-toggle nav-link dropdown-user-link"
                href="#"
                data-toggle="dropdown"
              >
                <div class="avatar avatar-online">
                  <img :src="userData.picture" alt="avatar" /><i></i>
                </div>
                <span class="user-name">{{ userData.name }}</span>
              </a>
              <div class="dropdown-menu dropdown-menu-right">
                <router-link class="dropdown-item" :to="{ name: 'profile.edit' }">
                  <i class="feather icon-user"></i> Edit Profile
                </router-link>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" @click.prevent="$emit('on-logout')">
                  <i class="feather icon-power"></i> Logout
                </a>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import { computed } from "vue";
export default {
  props: {
    user: Object,
    panelType: String,
  },
  setup(props) {
    return {
      userData: computed(() => props.user),
      type: computed(() => props.panelType),
    };
  },
};
</script>

<style scoped>
nav.header-navbar {
  background: rgb(34, 58, 102);
  background: linear-gradient(
    90deg,
    rgba(34, 58, 102, 1) 0%,
    rgba(28, 186, 159, 1) 100%,
    rgba(34, 58, 102, 1) 100%
  );
  height: 72px !important;
}
.brand-logo {
  width: 69%;
  background-color: #fff;
  border-radius: 15px;
}
.header-navbar .navbar-header .navbar-brand,
.dropdown-menu {
  padding: 0 !important;
}
i.icon-power {
  color: red !important;
}

i.icon-user {
  color: rgb(34, 58, 102);
}

a.dropdown-item:hover,
a.dropdown-item:focus-within,
a.dropdown-item:focus,
.dropdown .dropdown-menu .dropdown-item:active {
  background: rgb(34, 58, 102);
  background: linear-gradient(
    90deg,
    rgba(34, 58, 102, 1) 0%,
    rgba(28, 186, 159, 1) 100%,
    rgba(34, 58, 102, 1) 100%
  );
  color: #fff;
}

a.dropdown-item:hover i,
a.dropdown-item:focus-within i,
a.dropdown-item:focus i,
.dropdown .dropdown-menu .dropdown-item:active i {
  color: #fff !important;
}
.dropdown-divider {
  margin: 0 !important;
}
</style>
