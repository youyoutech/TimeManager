<template >
  <nav v-if="currentUser" class="navbar navbar-expand-lg">
    <div class="container-fluid">
      <h2 class="navbar-title">{{ $route.meta.title }}</h2>
      <div class="collapse navbar-collapse justify-content-end">
          <ul class="nav navbar-nav mr-auto"></ul>
          <ul class="navbar-nav ml-auto">
            <clock-button/>
            <li class="nav-item"><router-link class="nav-link" :to="{name: 'profile'}">Account</router-link></li>
            <li class="nav-item"><button type="button" @click="disconnectAccount()" class="nav-link">Disconnect</button></li>
          </ul>
      </div>
    </div>
  </nav>
</template>

<script>
// @ is an alias to /src

import ClockButton from "./ClockButton"
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'navbar',
  components: {
    ClockButton
  },
  computed: {
    ...mapGetters('user_store', ['currentUser']),
  },
  methods: {
    ...mapActions('user_store', ['disconnectUser']),
    disconnectAccount() {
      let confirm = window.confirm("Are you sure you want to disconnect?");
      if (confirm)
        this.disconnectUser();
        this.$router.go("/login");
    },
  }
};
</script>
