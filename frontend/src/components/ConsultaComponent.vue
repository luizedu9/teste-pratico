<template>
  <div class="container">

    <b-container class="border">

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
      }
    },
    created() { // Inicializa informações necessarias - Data, codigo venda, clientes e produtos
      axios.get(`http://localhost:5000/startConsulta`).then((response) => {
        if (response.data.status == 0) {
          this.consulta = response.data.consulta;
          // eslint-disable-next-line
          console.log(response.data);
        } else {
          this.message = 'Houve um erro inesperado. Tente mais tarde';
          this.warningAlert = true;
        }
      })
    },
    filters: {
      reformat: function (value) { // Reformata Float para aparecer com ","
        return value.toFixed(2).toString().replace('.', ',');
      },
    }, 
  }
  // eslint-disable-next-line
  // console.log("!");
</script>