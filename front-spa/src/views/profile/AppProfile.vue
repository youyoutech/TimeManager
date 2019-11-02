<template>
  <div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-md-8">
          <div class="card">
            <div class="card-body">
              <h4>Edit profile</h4>
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
                <button type="button" @click="updateAccount()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Update</button>
              </v-form>
            </div>
          </div>
        </div>
        <div class="col-md-4">
          <div class="card">
            <div class="card-body">
              <img class="img-avatar" src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/20625/avatar-bg.png" alt="">
              <h5>{{ formFields.username }}</h5>
              <a href="#">{{ formFields.email }}</a>
              <div class="btn-box mt-4">
                <button type="button" @click="deleteAccount()" class="btn btn-primary">Delete</button>
                <button type="button" @click="disconnectAccount()" class="btn btn-primary">Disconnect</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import axios from 'axios';
import { mapGetters, mapActions } from 'vuex'
export default {
  name: 'profile',
  components: {
  },
  data () {
    return {
      valid:false,
      formFields: {
        username: null,
        email: null,
        password: null,
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
  created() {
    this.formFields = 
      this.currentUser ? 
      this.currentUser : 
      { username: null,
        email: null,
        password: null,
      }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser'])
  },
  methods: {
    ...mapActions('user_store', ['deleteUser', 'disconnectUser', 'updateUser']),
    deleteAccount() {
      let confirm = window.confirm("Are you sure you want to delete your account?");
      if (confirm)
        this.deleteUser(this.currentUser.id);
    },
    disconnectAccount() {
      let confirm = window.confirm("Are you sure you want to disconnect?");
      if (confirm)
        this.disconnectUser();
    },
    updateAccount() {
      if (this.valid) {
        let confirm = window.confirm("Are you sure you want to edit your account informations?");
        if (confirm)
          this.updateUser(this.formFields)
      } else {
        this.$notify({
          title: 'Form is not valid',
          text: 'Please respect the conditions',
          type: 'error',
          closeOnClick: true
        })
      }
    },
    resetForm() {
      this.formFields = {
        email: null,
        password: null
      }
    }
  },
};
</script>
