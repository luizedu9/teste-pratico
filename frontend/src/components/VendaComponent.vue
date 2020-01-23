<template>
  <div class="container">

    <form>

      <b-container class="bv-example-row">
        <b-row>
          <b-col>
            <!-- Número Venda -->
            <label for="numero_venda" class="col-sm-5">Número da Venda: XXXXXX</label>
          </b-col>
          <b-col>
          <!-- Data -->
            <label for="data" class="col-sm-5">Data da Venda: {{ form.date }} </label>
          </b-col>  
        </b-row>
      </b-container>

      <!-- Cliente -->
      <b-container class="row">
        <label for="cliente" class="col-sm-2 col-form-label">Cliente:</label>
        <div class="col-sm-10">
          <input type="text" class="form-control" id="cliente" v-model="cliente">
        </div>
      </b-container>
      <!-- CEP -->
      <b-container class="row">
        <label for="cep" class="col-sm-2 col-form-label">CEP:</label>
        <div class="col-sm-10">
          <input class="form-control" id="cep" v-on:blur="calculaCep" v-model="form.cep" v-mask="'#####-###'"/>
        </div>
      </b-container>
      <!-- Endereço de Entrega -->
      <b-container class="border">
        <b-row>
          <b-col class="border">
            <form class="form-inline"> <!-- Logradouro -->
              <label for="logradouro" class="col-form-label">Logradouro:</label>
              <input type="text" class="form-control" id="logradouro" v-model="form.logradouro">
            </form>
          </b-col>
          <b-col>
            <form class="form-inline"> <!-- Complemento -->
              <label for="complemento" class="col-form-label">Complemento:</label>
              <input type="text" class="form-control" id="complemento" v-model="form.complemento">
            </form>
          </b-col>
          <b-col> 
            <form class="form-inline"> <!-- Número -->
              <label for="numero" class="col-form-label">Nº:</label>
              <input type="text" class="form-control" id="numero" size="1" v-model="form.numero">
            </form>
          </b-col>  
        </b-row>

        <b-row>
          <b-col>
            <form class="form-inline"> <!-- Bairro -->
              <label for="bairro" class="col-form-label">Bairro:</label>
              <input type="text" class="form-control" id="bairro" v-model="form.bairro">
            </form>
          </b-col>
          <b-col>
            <form class="form-inline"> <!-- Localidade -->
              <label for="localidade" class="col-form-label">Localidade:</label>
              <input type="text" class="form-control" id="localidade" v-model="form.localidade">
            </form>
          </b-col>
          <b-col>
            <form class="form-inline"> <!-- UF -->
              <label for="uf" class="col-form-label">UF:</label>
              <input type="text" class="form-control" id="uf" size="1" v-model="form.uf">
            </form>
          </b-col>  
        </b-row>
      </b-container>

    </form>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment'

  export default {
    data() {
      return {
        cliente: '',
        form: {
          cliente: '',
          date: '',
          cep: '',
          logradouro: '',
          numero: '',
          complemento: '',
          bairro: '',
          localidade: '',
          uf: '',
        },
      }
    },
    created() { // Inicializa informações necessarias
      this.form.date = moment(new Date()).format("DD/MM/YYYY");
    },
    methods: {
      calculaCep() {
        axios.get("https://viacep.com.br/ws/" + this.form.cep + "/json/")
          .then(response => (
            this.form.logradouro = response.data.logradouro,
            this.form.numero = response.data.numero,
            this.form.complemento = response.data.complemento,
            this.form.bairro = response.data.bairro,
            this.form.localidade = response.data.localidade,
            this.form.uf = response.data.uf));
      },
    }
  }
</script>