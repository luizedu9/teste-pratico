<template>
  <div class="container">

    <div class="alert alert-danger" role="alert" v-if="alert">
      {{ alertMessage }}
    </div>

    <b-container class="border">

      <b-row>
        <b-col class="border">
          Relação de Vendas
        </b-col>
      </b-row>

      <b-row> <!-- Cabeçalho -->
        <b-col class="border"> 
          Número da Venda:
        </b-col>
        <b-col class="border"> 
          Data da Venda:
        </b-col>
        <b-col class="border" cols=6> 
          Cliente:
        </b-col>
        <b-col class="border"> 
          Total:
        </b-col>
      </b-row>

      <!-- v-for passa por cada elemento da lista de vendas -->
      <b-row v-for="linha in this.consulta" :key='linha'> <!-- Valores -->
        <b-col class="border"> 
          {{linha.codigo}}
        </b-col>
        <b-col class="border"> 
          {{linha.data}}
        </b-col>
        <b-col class="border" cols=6> 
          {{linha.cliente}}
        </b-col>
        <b-col class="border"> 
          {{linha.total | reformat}}
        </b-col>
      </b-row>

    </b-container>
    
  </div>
</template>

<script>
import axios from 'axios'; // Requisições a API

  export default {
    data() {
      return {
        consulta: '',
        alert: false,
        alertMessage: "", 
      }
    },
    created() { // Inicializa informações necessarias - Data, codigo venda, clientes e produtos
      axios.get(`http://localhost:5000/startConsulta`).then((response) => {
        if (response.data.status == 0) {
          this.consulta = response.data.consulta;
        } else {
          this.alert = true;
          this.alertMessage = 'Houve um erro inesperado. Tente mais tarde';
        }
      }).catch(error => {
        // eslint-disable-next-line
        console.log(error.response);
        this.alert = true
        this.alertMessage = "O servidor não está respondendo. Tente mais tarde!"
      });
    },
    filters: {
      reformat: function (value) { // Reformata Float para aparecer com ","
        return value.toFixed(2).toString().replace('.', ',');
      },
    }, 
  }
</script>