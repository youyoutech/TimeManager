<template>
  <div>
   <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-stretch auth auth-img-bg">
        <div class="row flex-grow">
          <div class="col-lg-12 d-flex align-items-center justify-content-center">
            <div class="register-form">
              <h1>Register</h1>
              <p>Don't have an account yet?</p>
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
                    <v-text-field  
                      v-model="formFields.password" 
                      type="password"
                      placeholder="Enter a password"
                      :counter="20"
                      label="Password"
                      :rules="passwordRules"
                      />
                  </div>
                </div>
                <div class="form-group row">
                  <div class="col-sm-12">
                    <v-text-field  
                      v-model="passwordConfirm" 
                      type="password"
                      placeholder="Enter a password"
                      :counter="20"
                      label="Password confirm"
                      :rules="passwordRules"
                      />
                  </div>
                </div>
              <button @click="createUser()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Register</button>
              </v-form>
              <p>Already have an account? <router-link class="link" :to="{name: 'login'}">Login </router-link></p>
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
  title: 'Register',
  name: 'register',
  components: {
  },
  data () {
    return {
      valid:false,
      user: {
        data: {
          username: '',
          email: '',
          id: ''  
        }
      },
      formFields: {
        email: null,
        username: null,
        password: null,
        role_id: 1,
        team_id : 1
      },
      passwordConfirm: null,
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
      passwordRules: [
          v => !!v || "Ce champs est obligatoire",
          v => v && v.length <= 20 || "Ce champs doit contenir au maximum 20 caractères",
          v => v && v.length >= 8 || "Ce champs doit contenir au minimum 8 caractères",
          v => /[a-z]+/.test(v) || "Le mot de passe doit contenir au moins une miniscule",
          v => /[A-Z]+/.test(v) || "Le mot de passe doit contenir au moins une majuscule",
          v => /[0-9]+/.test(v) || "Le mot de passe doit contenir au moins un chiffre",
          v => (this.formFields.password == this.passwordConfirm || this.passwordConfirm == this.formFields.password) || 'Password must match'
      ],
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser'])
  },
  methods: {
    ...mapActions('user_store', ['register']),
    createUser() {
      if (this.valid) {
        this.register(this.formFields);
        this.resetForm();
        this.$router.push({ name: 'login', query: { redirect: '/' } });
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
        username: null,
        password: null,
        role: 1,
        team: 1
      };
      this.passwordConfirm = null
    }
  },
};
</script>