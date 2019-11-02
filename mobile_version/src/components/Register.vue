<template>
  <div class="Login mx-4">
    <h1>Register</h1>
    <p>Sign in to continue using Time Manager</p>
    <v-form v-on:submit.prevent v-model="valid">
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
      <button @click="register()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Login</button>
    </v-form>
    <p>
        Already have an account?
      <router-link class="link" to="/login">Login</router-link>
    </p>
  </div>
</template>

<script>
export default {
  name: "Register",
  data() {
    return {
      valid: false,
      formFields: {
        username: null,
        email: null,
        password: null,
        role: 1,
        team: 1
      },
        nameRules: [
        v => !!v || "Ce champs est obligatoire!",
        v => v && v.length <= 12 || "Ce champs doit contenir au maximum 12 caractères",
        v => v && v.length >= 4 || "Ce champs doit contenir au minimum 4 caractères"
      ],
      emailRules: [
        v => !!v || "Ce champs est obligatoire!",
        v =>
          /.+@.+/.test(v) ||
          "Veuillez remplir avec un E-mail valide (***@***.**)",
        v =>
          (v && v.length <= 50) ||
          "Ce champs doit contenir au maximum 50 caractères"
      ],
      passwordRules: [
        v => !!v || "Ce champs est obligatoire",
        v =>
          (v && v.length <= 20) ||
          "Ce champs doit contenir au maximum 20 caractères",
        v =>
          (v && v.length >= 8) ||
          "Ce champs doit contenir au minimum 8 caractères",
        v =>
          /[a-z]+/.test(v) ||
          "Le mot de passe doit contenir au moins une miniscule",
        v =>
          /[A-Z]+/.test(v) ||
          "Le mot de passe doit contenir au moins une majuscule",
        v =>
          /[0-9]+/.test(v) ||
          "Le mot de passe doit contenir au moins un chiffre"
      ]
    };
  },
  computed: {},
  methods: {
      register() {
        let payload = {
            method: 'POST',
            body: this.formFields
        }
        return fetch('http://localhost:8080/api/register', payload)
            .then((response) => {
            if (response.data.meta.token) {
                router.push('/login')
            }
                return response;
            }).catch((e) => {
                return null;
            });
        }
    }
};
</script>
