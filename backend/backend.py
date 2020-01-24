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
cursor.execute("SELECT VERSION()")
data = cursor.fetchone()
print ("Database version : %s " % data)

#######################################################################################################
#                                                                                                     #
#                                                 ROUTER                                              #
#                                                                                                     #
#######################################################################################################

# STATUS:
#   0 - SUCESSO
#   1 - OCORREU UM PROBLEMA INESPERADO
@app.route('/startVenda', methods=['GET'])
def startVenda():
    if request.method == 'GET':
        
        #clientes = find_clientes()
        if (True):
            cod = 9999
            clientes = [{'value': '1', 'text': 'a'}, {'value': '2', 'text': 'b'}]
            produtos = [{'value': '1', 'text': 'x'}, {'value': '2', 'text': 'z'}]
            return jsonify({'status': '0', 'codigoVenda': cod, 'clientes': clientes, 'produtos': produtos })
        else:
            return jsonify({'status': '1'})

#######################################################################################################
#                                                                                                     #
#                                               INIT                                                  #
#                                                                                                     #
#######################################################################################################

# Inicia servidor
if __name__ == "__main__":
    app.run()