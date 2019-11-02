import Vue from 'vue';
import Router from 'vue-router';
import Home from '../../views/AppHome.vue';
import Clock from '../../views/profile/AppClock.vue';
import Login from '../../views/auth/AppLogin.vue';
import Register from '../../views/auth/AppRegister.vue';
import Chart from '../../views/profile/AppChart.vue';
import Profile from '../../views/profile/AppProfile.vue';
import Manager from '../../views/admin/AppManager.vue';
import Admin from '../../views/admin/AppAdmin.vue';
import EditAdmin from '../../views/admin/AppEditAdmin.vue';
import GlobalGraph from '../../views/admin/AppAdminGlobalGraph.vue';
import TeamEditAdmin from '../../views/admin/AppEditAdmin.vue'
import TeamManagementAdmin from '../../views/admin/AppAdminManagement.vue'
import ChartManager from '../../views/admin/AppChartManager.vue';
import FourOFour from '../../views/error/FourOFour.vue';

Vue.use(Router);

const router = new Router({
  base: process.env.BASE_URL,
  mode: 'history',
  routes: [
    {
      path: '/',
      title: 'Dashboard',
      meta: {title: 'Dashboard'},
      name: 'home',
      component: Home,
    },
    {
      path: '/clock',
      title: 'Clock',
      meta: {title: 'Clock'},
      name: 'clock',
      component: Clock,
    },
    {
      path: '/register',
      title: 'Register',
      meta: {title: 'Register'},
      name: 'register',
      component: Register,
    },
    {
      path: '/login',
      title: 'Login',
      meta: {title: 'Login'},
      name: 'login',
      component: Login,
    },
    {
      path: '/chart',
      title: 'Chart Manager',
      meta: {title: 'Chart Manager'},
      name: 'chart',
      component: Chart,
    },
    {
      path: '/profile',
      title: 'Profile',
      meta: {title: 'Profile'},
      name: 'profile',
      component: Profile,
    },
    {
      path: '/manager',
      title: 'Manager',
      name: 'manager',
      meta: {title: 'Manager'},
      component: Manager,
    },
    {
      path: '/admin',
      title: 'Manager',
      name: 'admin',
      meta: {title: 'Admin'},
      component: Admin,
    },
    {
      path: '/admin/edit/:id',
      title: 'Admin user edition',
      name: 'admin/edit',
      meta: {title: 'Admin user edition'},
      component: EditAdmin,
    },
    {
      path: '/admin/team/edit/:id',
      title: 'Admin team edition',
      name: 'admin/team/edit',
      meta: {title: 'Admin team edition'},
      component: TeamEditAdmin,
    },
    {
      path: '/admin/globalgraph/',
      title: 'Admin global graph',
      name: 'admin/globalgraph',
      meta: {title: 'Admin global graph'},
      component: GlobalGraph,
    },
    {
      path: '/admin/team/management/:id',
      title: 'Admin team management',
      name: 'admin/team/management',
      meta: {title: 'Admin team management'},
      component: TeamManagementAdmin,
    },
    {
      path: '/manager/chart/:id',
      title: 'Manager graph',
      name: 'manager/chart',
      meta: {title: 'Manager graph'},
      component: ChartManager,
    },
    {
      path: '/*',
      title: 'Not found',
      name: 'fourofour',
      meta: {title: 'Not found'},
      component: FourOFour,
    },
  ],
});

export default router
router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register'];
  const managerPages = ['/manager'];
  const adminPages = ['/admin'];

  const authRequired = !publicPages.includes(to.path);
  const managerRequired = to.path.includes(managerPages);
  const adminRequired = to.path.includes(adminPages);

  const loggedIn = localStorage.getItem('user');
  const role = JSON.parse(localStorage.getItem('user')) ? JSON.parse(localStorage.getItem('user')).role_id : '';

  if (authRequired && !loggedIn) {
    Vue.notify({
      title: 'Connect first',
      text: "This route is not allowed if you are not connected",
      type: 'error',
      closeOnClick: true
    })
    return next('/login');
  }

  if (managerRequired && role == 1) {
    Vue.notify({
      title: 'Route not allowed',
      text: "You need manager rights to acces this page",
      type: 'error',
      closeOnClick: true
    })
    return next('/login');
  }

  if (adminRequired && !(role == 3)) {
    Vue.notify({
      title: 'Route not allowed',
      text: "You need admin rights to acces this page",
      type: 'error',
      closeOnClick: true
    })
    return next('/login');
  }

  document.title = to.meta.title

  next();
})
