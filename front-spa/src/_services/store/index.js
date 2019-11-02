import Vue from 'vue';
import Vuex from 'vuex';

import { user_store } from './user_store';
import { admin_store } from './admin_store';
import { manager_store } from './manager_store';

Vue.use(Vuex);

export const store = new Vuex.Store({
    modules: {
      user_store,
      admin_store,
      manager_store
    }
});
