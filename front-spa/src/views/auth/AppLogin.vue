<template>
  <div>
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-stretch auth auth-img-bg">
        <div class="row flex-grow">
          <div class="col-lg-12 d-flex align-items-center justify-content-center">
            <div class="login-form">
              <h1>Login</h1>
              <p>Sign in to continue using Time Manager</p>
              <v-form v-on:submit.prevent v-model="valid">
                <div class="form-group row">
                  <div class="col-sm-12">
                    <v-text-field
                      v-model="formFields.email"
                      type="text"
                      placeholder="Enter your mail"
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
                      placeholder="Enter your password"
                      :counter="20"
                      label="Password"
                      :rules="passwordRules"
                      />
                  </div>
                </div>
                <button @click="connect()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Login</button>
              </v-form>
              <p>Don't have an account? <router-link class="link" :to="{name: 'register'}">Register </router-link></p>
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
  name: 'login',
  components: {
  },
  data () {
    return {
      valid: false,
      formFields: {
        email: null,
        password: null
      },
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
      ],
    }
  },
  computed: {
    ...mapGetters('user_store', ['currentUser'])
  },
  methods: {
    ...mapActions('user_store', ['newClockList', 'setNextClockStatus', 'login']),
    connect() {
      if (this.valid) {
        this.login(this.formFields),
        this.resetForm()
      } else {
        this.$notify({
          title: 'Invalid form',
          text: 'Please respect the form conditions',
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
