<template>
  <div v-if="modifiedUser">
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-12">
          <div class="card">
            <div class="card-body">
              <h4>Edit User</h4>
              <v-form v-on:submit.prevent v-model=valid>
                <div class="form-group row">
                  <div class="col-sm-12">
                    <v-text-field 
                      v-model="formFields.username" 
                      type="text" 
                      placeholder="Example" 
                      :counter="12"
                      label="Username"
                      :rules="nameRules"
                      />
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-sm-12">
                    <v-text-field  
                      v-model="formFields.email" 
                      type="email"
                      placeholder="email@example.com"
                      :counter="50"
                      label="E-mail"
                      :rules="emailRules"
                      />
                  </div>
                </div>
                  <div class="form-group row">
                  <div class="col-sm-12">
                    <select v-model="formFields.role_id" class="custom-select" id="inputGroupSelect01">
                      <option value=1>User</option>
                      <option value=2>Manager</option>
                      <option value=3>Admin</option>
                    </select>
                  </div>
                </div>
                  <div class="form-group row">
                  <div class="col-sm-12">
                    <select v-model="formFields.team_id" class="custom-select" id="inputGroupSelect01">
                      <option 
                        v-for="team in teamList" 
                        :key="team.id"
                        :value=team.id>{{ team.name }}</option>
                    </select>
                  </div>
                </div>
              <button @click="updateAccount()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Update</button>
              </v-form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div v-else>
    <h1>This user does not exist</h1>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from 'axios';
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'editadmin',
  created() {
    this.getTeamList();
    this.getUserAtCreate(this.$route.params.id);
  },
  components: {
  },
  data () {
    return {
      valid:false,
      formFields: {
        username: null,
        email: null,
        role_id: null,
        team_id: null,
      },
      nameRules: [
        v => !!v || "Ce champs est obligatoire!",
        v => v && v.length <= 12 || "Ce champs doit contenir au maximum 12 caractères",
        v => v && v.length >= 4 || "Ce champs doit contenir au minimum 4 caractères"
      ],
      emailRules: [
        v => !!v || "Ce champs est obligatoire!",
        v => /.+@.+/.test(v) || "Veuillez remplir avec un E-mail valide (***@***.**)",
        v => v && v.length <= 50 || "Ce champs doit contenir au maximum 50 caractères"
      ],
    }
  },
  computed: {
    ...mapGetters('admin_store', ['modifiedUser']),
    ...mapGetters('manager_store', ['teamList'])

  },
  methods: {
    ...mapActions('admin_store', ['getUserById', 'editUser']),
    ...mapActions('manager_store', ['getFullTeamList']),
    getUserAtCreate(userId) {
      this.getUserById(userId);
      setTimeout(this.fetchUserInfos, 100);
    },
    updateAccount() {
      let confirm = window.confirm("Are you sure you want to edit this account informations?");
      if (confirm)
        this.editUser(this.formFields)
    },
    getTeamList() {
      this.getFullTeamList();
    },
    resetForm() {
      this.formFields = {
        email: null,
        password: null
      }
    },
    fetchUserInfos() {
      this.formFields = this.modifiedUser;
    },
    getTeamLabelFromId(id) {
      let team = (_.find(this.teamList, function(t) { return t.id = id; }));
      return team && team.name ? team.name : '';
    }
  },
};
</script>
