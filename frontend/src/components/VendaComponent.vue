<template>
  <div class="container">

    <div class="alert alert-danger" role="alert" v-if="alert">
      {{ alertMessage }}
    </div>

    <b-container class="border">

      <b-row> <!-- Código venda / data -->
        <b-col class="border" cols="8"> <!-- Número Venda -->
          Número da Venda: {{ form.numVenda }}
        </b-col>
        <b-col class="border"> <!-- Data -->
          Data da Venda: {{ form.date }}
        </b-col>  
      </b-row>

      <b-row> <!-- Cliente / CEP -->
        <b-col cols="8"  class="border">
          Cliente
           <model-list-select style="margin-bottom:0.3em;" :list="clientes" v-model="form.cliente" option-value="codigo" option-text="nome"></model-list-select>
        </b-col>
        <b-col class="border">
          CEP
          <input class="form-control" style="margin-bottom:0.3em;" id="cep" v-on:blur="calculaCep" v-model="form.cep" v-mask="'#####-###'"/>
        </b-col>
      </b-row>

      <b-row> <!-- Endereço de Entrega -->
        <b-col class="border" cols="6">
          Logradouro:
          <input type="text" style="margin-bottom:0.3em;" class="form-control" id="logradouro" v-model="form.logradouro">
        </b-col>
        <b-col class="border">
          Complemento:
          <input type="text" style="margin-bottom:0.3em;" class="form-control" id="complemento" v-model="form.complemento">
        </b-col>
        <b-col class="border" cols="1"> 
          Nº:
          <input type="text" style="margin-bottom:0.3em;" class="form-control" id="numero" size="1" v-model="form.numero">
        </b-col>  
      </b-row>
      <b-row>
        <b-col class="border" cols="6">
          Bairro:
          <input type="text" style="margin-bottom:0.3em;" class="form-control" id="bairro" v-model="form.bairro">
        </b-col>
        <b-col class="border">
          Localidade:
          <input type="text" disabled style="margin-bottom:0.3em;" class="form-control" id="localidade" v-model="form.localidade">
        </b-col>
        <b-col class="border" cols="1">
          UF:
          <input type="text" disabled style="margin-bottom:0.3em;" class="form-control" id="uf" size="1" v-model="form.uf">
        </b-col>  
      </b-row>

      <b-row> <!-- Lista de Compras -->
        <b-col class="border" cols="1">
          Item
          <br>
          {{itemCont}}
        </b-col>
        <b-col class="border">
          Cód. Produto
          <model-list-select style="margin-bottom:0.3em;" :list="produtos" v-model="item.produto" option-value="codigo" option-text="codigo"></model-list-select>
        </b-col>
        <b-col cols="3" class="border">
          Desc. Produto
           <model-list-select style="margin-bottom:0.3em;" :list="produtos" v-model="item.produto" option-value="codigo" option-text="descricao"></model-list-select>
        </b-col>
        <b-col class="border">
          Preço
          <input type="number" style="margin-bottom:0.3em;" class="form-control" id="preco" v-model="item.preco" @input="calculaTotal">
        </b-col>
        <b-col class="border">
          Quantidade
          <input type="number" style="margin-bottom:0.3em;" class="form-control" id="quantidade" v-model="item.quantidade" @input="calculaTotal">
        </b-col>
        <b-col class="border">
          Total
          <br>
          {{item.total | reformat}}
        </b-col>
        <b-col class="border" cols="1">
          <b-button style="margin-left:-0.5em; margin-top:1em" type="submit" size="sm" variant="primary" @click="submitItem">Adicionar</b-button>
        </b-col>
      </b-row>

      <b-row v-for="forItem in this.form.itens" :key='forItem'> <!-- Lista de Compras -->
        <b-col class="border" cols="1">
          {{forItem.codItem}}
        </b-col>
        <b-col class="border">
          {{forItem.produto.codigo}}  
        </b-col>
        <b-col cols="3" class="border">
          {{forItem.produto.descricao}} 
        </b-col>
        <b-col class="border">
          {{forItem.preco | reformat}}          
        </b-col>
        <b-col class="border">
          {{forItem.quantidade | reformat}}
        </b-col>
        <b-col class="border">
          {{forItem.total | reformat}}
        </b-col>
        <b-col class="border" cols="1">
        </b-col>
      </b-row>

      <b-row>
         <b-col class="border" cols="8">
        </b-col>
        <b-col class="border">
          Total
          <br>
          {{form.valorTotal | reformat}}
        </b-col>
        <b-col class="border" cols="1" >
          <b-button type="submit" style="margin-left:-0.3em; margin-top:0.5em" size="sm" variant="success" @click="submitVenda">Finalizar</b-button>
        </b-col>
      </b-row>

    </b-container>  

  </div>
</template>

<script>
import axios from 'axios'; // Requisições a API
import moment from 'moment' // Data
import { ModelListSelect } from 'vue-search-select' // Input de pesquisa do cliente e produto

  export default {
    data() {
      return {
        itemCont: 1,
        clientes: [],
        produtos: [],
        item: {
          codItem: '',
          produto: {
            codigo: '',
            descricao: '',
          },
          preco: '',
          quantidade: '',
          total: 0.00,
        },
        form: {
          numVenda: '',
          cliente: {
            codigo: '',
            nome: '',
          },
          date: '',
          cep: '',
          logradouro: '',
          numero: '',
          complemento: '',
          bairro: '',
          localidade: '',
          uf: '',
          itens: [],
          valorTotal: 0.00,
        },
        alert: false,
        alertMessage: "",        
      }
    },
    created() { // Inicializa informações necessarias - Data, codigo venda, clientes e produtos
      this.form.date = moment(new Date()).format("DD/MM/YYYY");
      axios.get(`http://localhost:5000/startVenda`).then((response) => {
        if (response.data.status == 0) {
          this.form.numVenda = response.data.codigoVenda;
          this.clientes = response.data.clientes;
          this.produtos = response.data.produtos;
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
    methods: {
      calculaCep() { // responsavel pela busca do endereço de entrega via CEP
        axios.get("https://viacep.com.br/ws/" + this.form.cep + "/json/")
          .then(response => (
            this.form.logradouro = response.data.logradouro,
            this.form.numero = response.data.numero,
            this.form.complemento = response.data.complemento,
            this.form.bairro = response.data.bairro,
            this.form.localidade = response.data.localidade,
            this.form.uf = response.data.uf));
      },
      calculaTotal() { // Calcula valor final (Preço * Quantidade)
        this.item.total = this.item.quantidade.replace(",", ".") * this.item.preco.replace(",", ".")
      },
      submitItem() {
        if (this.item.produto.codigo == "") {
          this.alert = true
          this.alertMessage = "Cód. Produto / Desc. Produto requerido!"
        } else if (this.item.preco == "" || this.item.preco == 0) {
          this.alert = true
          this.alertMessage = "Preço do produto requerido!"
        } else if (this.item.quantidade == "" || this.item.quantidade == 0) {
          this.alert = true
          this.alertMessage = "Quantidade do produto requerida!"
        } else {
          this.alert = false
          this.item.codItem = this.itemCont
          this.item.preco = parseFloat(this.item.preco.replace(",", "."))
          this.item.quantidade = parseFloat(this.item.quantidade.replace(",", "."))
          this.form.itens.push(Object.assign({}, this.item)); // Adiciona item a compra
          this.itemCont = this.itemCont + 1 // Incrementa contador
          this.form.valorTotal = this.form.valorTotal + this.item.total;
          this.item.produto = {'codigo': '', 'descricao': ''}
          this.item.preco = ''
          this.item.quantidade = ''
          this.item.total = 0.00
        }
      },
      submitVenda() {
        axios.post('http://localhost:5000/insertVenda', this.form).then((res) => {      
          // eslint-disable-next-line
          console.log(res);});
      }

    },
    components: {
      ModelListSelect
    },
  }
  // eslint-disable-next-line
  // console.log("!");
</script>