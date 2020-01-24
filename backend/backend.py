# -*- coding: utf-8 -*-

# Teste Pratico
# Backend.py
# Luiz Eduardo Pereira

from flask import Flask, jsonify, request, Blueprint, current_app
from flask_cors import CORS
import json
import requests
import os
import sys
from datetime import datetime, timedelta
import pymysql

#######################################################################################################
#                                                                                                     #
#                                                 INIT                                                #
#                                                                                                     #
#######################################################################################################

# Configuração Flask
DEBUG = True
app = Flask(__name__)
app.config.from_object(__name__)
CORS(app)

# Configuração PyMySQL
db = pymysql.connect("localhost", "admin", "admin7576", "teste_pratico")
cursor = db.cursor()

#######################################################################################################
#                                                                                                     #
#                                                 ROUTER                                              #
#                                                                                                     #
#######################################################################################################

# STATUS:
#   0 - SUCESSO
#   1 - OCORREU UM PROBLEMA INESPERADO

# Retorna dados necessario para o funcionamento da venda
@app.route('/startVenda', methods=['GET'])
def startVenda():
    if request.method == 'GET':
        try:
            cod = find_numero_venda() # Coleta dados do codigo da venda, clientes e produtos
            clientes = find_all_clientes()
            produtos = find_all_produtos()
            return jsonify({'status': '0', 'codigoVenda': cod, 'clientes': clientes, 'produtos': produtos })
        except: # Se ocorrer algum erro, retorna status de erro
            return jsonify({'status': '1'})

# Insere dados da venda ao banco de dados
@app.route('/insertVenda', methods=['POST'])
def insertVenda():
    if request.method == 'POST':
        try:
            post_data = request.get_json()
            print(post_data)
            return jsonify({'status': '0'})
        except: # Se ocorrer algum erro, retorna status de erro
            return jsonify({'status': '1'})

#######################################################################################################
#                                                                                                     #
#                                               BD                                                    #
#                                                                                                     #
#######################################################################################################

# Retorna clientes cadastrados (Lista de dicionarios)
def find_all_clientes():
    cursor.execute("SELECT * FROM Cliente;")
    resultados = cursor.fetchall()
    clientes = []
    for result in resultados: # Transforma o resultado em lista de dicionarios
        clientes.append({"codigo": result[0], "nome": result[1], "cnpj": result[2]})
    return(clientes)

# Retorna o número de vendas cadastradas
def find_numero_venda():
    cursor.execute("SELECT * FROM Venda;")
    return(len(cursor.fetchall()) + 1) # Número da ultima venda + 1

# Retorna produtos cadastrados (Lista de dicionarios)
def find_all_produtos():
    cursor.execute("SELECT * FROM Produto;")
    resultados = cursor.fetchall()
    produtos = []
    for result in resultados:
        produtos.append({"codigo": result[0], "descricao": result[1]})
    return(produtos)

#######################################################################################################
#                                                                                                     #
#                                               INIT                                                  #
#                                                                                                     #
#######################################################################################################

# Inicia servidor
if __name__ == "__main__":
    app.run()