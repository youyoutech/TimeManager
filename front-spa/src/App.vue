<template>
  <div id="app" :class="currentRouteName">
    <div class="wrapper">
      <notifications/>
      <sidebar/>
      <div class="main-panel">
        <navbar/>
        <div class="content">
          <router-view class="height100"/>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Sidebar from '@/components/Sidebar.vue';
import Navbar from '@/components/Navbar.vue';
import Footer from '@/components/Footer.vue';

export default {
  name: 'app',
  components: {
    Sidebar,
    Navbar,
    Footer,
  },
  computed: {
    currentRouteName() {
      return this.$route.name;
    }
  }
};
</script>
<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #212529;
}
body,
.text-white {
  color: white;
}
a {
  color: #9399c5;
}
a:hover,
.no-link {
  text-decoration: none;
  color: inherit;
}
.btn-primary {
  background: #405189;
  border: 0;
  padding: 6px 15px;
}
.btn-primary:hover {
  background: #596ba7;
}
.main-panel, .sidebar {
  max-height: 100%;
  height: 100%;
  transition-property: top,bottom;
  transition-duration: .2s,.2s;
  transition-timing-function: linear,linear;
  -webkit-overflow-scrolling: touch;
}
.input-group .input-group-prepend label {
  background: #22243c;
  border-color: #2a2c40;
  padding: 0 0.75rem;
  color: #aaa7a7;
}
.input-group select {
  border: 1px solid #2a2c40;
  height: 3rem;
  padding: 0rem 1.375rem;
  font-size: 1rem;
  font-weight: 400;
  line-height: initial;
  color: #e9e6e6;
  background-color: #2b2e4c;
  background-clip: padding-box;
  border-radius: 2px;
}
/* --- Sidebar --- */
.sidebar {
  position: absolute;
  background-color: #131633;
  top: 0;
  bottom: 0;
  left: 0;
  width: 260px;
  display: block;
  z-index: 1;
  color: #fff;
  font-weight: 200;
  background-size: cover;
  background-position: 50%;
}
.sidebar .logo-img {
  text-transform: uppercase;
  font-weight: 500;
  letter-spacing: 2.2px;
  padding: 7.5px 0;
  margin: 0;
  border-bottom: 1px solid #2a2c40;
  position: relative;
  z-index: 4;
}
.sidebar .logo-img img {
  object-fit: contain;
  background: white;
  padding: 7px;
  border-radius: 30px;
  width: 45px;
  height: 45px;
  margin-right: 9px;
}
.sidebar .logo-img svg {
  width: 45px;
  margin-right: 8px;
  transform-style: preserve-3d;
  transition: all 1s ease-in-out;
}
.sidebar .logo-img:hover svg {
  transform: rotateY(180deg);
}
.sidebar .logo-img svg path {
  fill: #fff;
}
.sidebar .nav {
  margin-top: 20px;
  float: none;
  display: block;
}
.sidebar .nav li a {
  display: flex !important;
  align-items: center;
  color: #fff;
  margin: 5px 15px;
  opacity: .86;
  border-radius: 4px;
  display: block;
  padding: 10px 15px;
  text-transform: uppercase;
  line-height: 30px;
  font-size: 14px;
  font-weight: 600;
  text-align: left;
  transition: all 0.2s ease;
}
.sidebar .nav li.active a,
.sidebar .nav li:hover a {
  color: #fff;
  opacity: 1;
  background: hsla(0,0%,100%,.23);
}
.sidebar .nav li a i {
  font-size: 20px;
  margin-right: 10px;
}
.main-panel {
  position: relative;
  float: right;
  width: calc(100% - 260px);
  min-height: 100%;
}
/* --- Navbar --- */
.navbar {
  border: 0;
  font-size: 16px;
  border-radius: 0;
  min-height: 50px;
  background-color: #131633;
  border-left: 1px solid #2a2c40;
  padding: 10px 15px;
}
.navbar .status-container {
  display: flex;
  align-items: center;
  margin-right: 1rem;
}
.navbar .status-container p {
  color: #fff;
  margin: 0;
}
.navbar .status-clock {
  display: flex;
  align-items: center;
  margin-left: 8px;
}
.navbar .status-clock span {
  display: block;
  width: 10px;
  height: 10px;
  border-radius: 100%;
  margin-right: 3px;
}
.navbar .btn-primary {
  margin-right: 1rem;
  text-transform: uppercase;
}
.navbar .navbar-title {
  color: white;
  font-weight: 400;
  margin: 5px 0;
  font-size: 20px;
}
.navbar .navbar-nav .nav-item a {
  color: white;
  padding: 10px 15px;
  position: relative;
  display: inline-flex;
  line-height: 1.2;
  transition: all 0.2s ease;
}
.navbar .navbar-nav .nav-item a:hover,
.navbar .navbar-nav .nav-item button:hover {
  color: #596ba7;
}
.main-panel .content .height100 {
  background: #222840;
  min-height: calc(100vh - 60px);
  padding: 1.5rem 1.2rem;
}
.login .content .height100,
.register .content .height100,
.login .content .height100 .container-fluid,
.register .content .height100 .container-fluid {
  min-height: 100vh;
  height: 100vh;
  background: transparent;
}
.nav-link {
  color: white;
}
/* General */
.card {
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #131633;
  background-clip: border-box;
  border: 1px solid #313452;
  border-radius: 0;
  color: white;
}
.card .card-body {
  padding: 1.25rem 1.75rem;
}
.card .card-body h4 {
  margin-bottom: 1rem;
}
/* Login & Register */
.login .main-panel,
.register .main-panel {
  width: 100%;
}
.login .main-panel .content,
.register .main-panel .content {
  padding: 0;
  background-image: url("assets/gotham-city.png");
  background-size: cover;
  overflow: hidden;
}
.login .main-panel .content::before,
.register .main-panel .content::before {
  content: "";
  display: block;
  background: linear-gradient(rgba(19,22,51,0.5), #9399c5);
  height: 100vh;
  width: 100%;
  position: absolute;
}
.v-text-field>.v-input__control>.v-input__slot:after {
  content: none;
}
.login .container-fluid,
.login .content-wrapper,
.register .content-wrapper,
.register .content-wrapper {
  height: 100%;
}
.login h1,
.login p,
.register h1,
.register p {
  color: white;
}
.login p,
.register p {
  margin-bottom: 0;
}
.login form,
.register form {
  width: 100%;
}
.login .login-form,
.register .register-form {
  width: 40%;
  margin: auto;
  display: block;
  position: relative;
  display: flex;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: rgba(19,22,51,0.8);
  background-clip: border-box;
  border: 1px solid #313452;
  border-radius: 0;
  padding: 2rem;
}
.login form input,
.register form input {
  border: 1px solid;
  border-radius: 5px;
  padding: 10px;
  margin-top: 13px;
  color: white !important;
  height: 45px;
  max-height: inherit;
  display: block;
  transition: all 0.2 ease;
}
.login form input:focus,
.register form input:focus {
  border-color:#9399c5;
}
.login form input::placeholder,
.register form input::placeholder {
  color: rgba(255,255,255,0.6) !important;
}
.register form button.btn,
.login form button.btn {
  width: 100%;
  border-radius: 0;
  background: #9399c5;
  border: 0;
  padding: 10px;
  margin-bottom: 1rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
.login .theme--light.v-label,
.login .theme--light.v-messages,
.register .theme--light.v-label,
.register .theme--light.v-messages,
.v-counter.theme--light {
  color: white !important;
}
.login .theme--light.v-label,
.register .theme--light.v-label {
  left: 0 !important;
  font-size: 18px;
}
.login .v-form > .form-group .col-sm-12,
.login .v-form > .form-group .v-input,
.register .v-form > .form-group .col-sm-12,
.register .v-form > .form-group .v-input {
  padding-top: 0 !important;
  padding-bottom: 0;
}
.login .v-form > .form-group:first-child .col-sm-12,
.register .v-form > .form-group:first-child .col-sm-12 {
  padding-top: 2rem !important;
}
.login .v-messages__message,
.register .v-messages__message {
  font-style: italic;
}
/* --- DASHBOARD --- */
.home .card h4 {
  text-align: left;
  margin: 0;
}
/* --- FORM --- */
.card form input {
  display: block;
  width: 100%;
  height: 2.8rem;
  padding: 0.8rem 1.2rem;
  line-height: 1;
  color: #e9e6e6 !important;
  background-color: #2b2e4c;
  border-radius: 2px;
  transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
  border: 1px solid #2a2c40 !important;
  font-weight: 400;
  font-size: 0.875rem;
  max-height: inherit;
  margin-top: 1rem;
}
.card form label {
  color: white;
  left: 0 !important;
  font-size: 20px;
}
.theme--light.v-label {
  color: white;
}
/* ---- PROFILE ---- */
.img-avatar {
  width: 95px;
  margin-bottom: 1rem;
}
/* Table */
.table {
  color: white;
}
.table thead th {
  color: white;
  border-top: 0;
  border-bottom-width: 1px;
  font-weight: 500;
  font-size: .875rem;
  text-transform: uppercase;
  vertical-align: bottom;
  border-bottom: 1px solid #2a2c40;
}
.table th, .table td {
  border-top: 1px solid #2a2c40;
}
.table-hover tbody tr {
  transition: all 0.2s ease;
  font-size: 15px;
}
.table-hover tbody tr:hover,
.table-hover tbody tr.active {
  color: white;
  background-color: #222840;
}
.badge {
  border-radius: 0;
  line-height: 1;
  font-size: 15px;
  padding: .375rem .5625rem;
  font-weight: normal;
}
.clock .badge {
  width: 18%;
}
.badge-warning {
  color: #fff;
  background-color: rgb(241, 83, 110);
}
.badge-success {
  color: #fff;
  background-color: #00c689;
}
.bg-success {
  background-color: #00c689 !important;
}
.color-success {
  color: #00c689 !important;
}
.bg-info {
  background-color: #3da5f4 !important;
}
.color-info {
  color: #3da5f4 !important;
}
.badge-info {
  background: #3da5f4 !important
}
.bg-danger {
  background-color: rgb(241, 83, 110) !important;
}
.color-danger {
  color: rgb(241, 83, 110) !important;
}
.bg-warning {
  background-color: #fda006 !important;
}
.color-warning {
  color: #fda006 !important;
}
.icon-rounded-inverse-success.icon-rounded-lg {
  width: 3.75rem;
  height: 3.75rem;
  background: white;
  border-radius: 50%;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
}
.icon-rounded-inverse-success.icon-rounded-lg i {
  font-size: 1.625rem;
}
</style>
