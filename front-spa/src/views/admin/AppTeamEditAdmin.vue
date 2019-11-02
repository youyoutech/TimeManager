<template>
  <div class="container-fluid" >
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-body">
            <v-form v-on:submit.prevent v-model=valid v-if="modifiedTeam">
                <div class="form-group row">
                    <div class="col-sm-12">
                    <v-text-field 
                        v-model="formFields.name" 
                        type="text" 
                        placeholder="Enter a team name" 
                        :counter="12"
                        label="Team name"
                        :rules="nameRules"
                        />
                    </div>
                </div>
                <button @click="editTeam()" :class="valid ? 'btn btn-primary' : 'btn btn-secondary'">Update</button>
            </v-form>
            <div v-else>
              <h1>This team does not exist.</h1>
              <router-link class="btn btn-primary" :to="{name: 'admin'}">Go back</router-link>
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
  name: 'teameditadmin',
  created() {
    this.getTeamList();
  },
  components: {
  },
  data () {
    return {
        valid: false,
        formFields: {
            name: null,
        },
        nameRules: [
            v => !!v || "Ce champs est obligatoire!",
            v => v && v.length <= 12 || "Ce champs doit contenir au maximum 12 caractères",
            v => v && v.length >= 4 || "Ce champs doit contenir au minimum 4 caractères"
        ],
    }
  },
  computed: {
    ...mapGetters('manager_store', ['teamList', 'modifiedTeam'])
  },
  methods: {
    ...mapActions('manager_store', ['getFullTeamList', 'updateTeam', 'getTeamById']),
    getTeamAtCreate(teamID) {
      this.getTeamById(teamID);
      setTimeout(this.fetchTeamInfos, 100);
    },
    editTeam() {
        if (this.valid) {
            let team = {
                'name': this.formFields.name,
                'id': this.$route.params.id
            }
            let confirm = window.confirm("Are you sure you want to edit this team informations?");
            if (confirm)
                this.updateTeam(team);
        } else {
            this.$notify({
                title: 'Form is not valid',
                text: 'Please respect the conditions',
                type: 'error',
                closeOnClick: true
            })
        }
    },
    getTeamList() {
       this.getFullTeamList();
    },
    resetForm() {
        this.formFields = {
            name: null,
        }
    },
    fetchTeamInfos() {
      this.formFields = this.modifiedTeam;
    },
  },
};
</script>
