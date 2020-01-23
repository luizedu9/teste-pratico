# -*- coding: utf-8 -*-

# Teste Pratico
#
# Backend.py
#
# Luiz Eduardo Pereira

from flask import Flask, jsonify, request, Blueprint, current_app
from flask_cors import CORS
import json
import requests
import os
import sys
from datetime import datetime, timedelta

#######################################################################################################
#                                                                                                     #
#                                                 INIT                                                #
#                                                                                                     #
#######################################################################################################

# Configuração Flask
app = Flask(__name__)
app.config.from_object(__name__)
CORS(app)

#######################################################################################################
#                                                                                                     #
#                                                 ROUTER                                              #
#                                                                                                     #
#######################################################################################################

# Recebe CEP / Retorna endereço json
def cep_request(cep):
	#valida_cep()
	try:
		response = requests.get("https://viacep.com.br/ws/" + cep + "/json/") # Realiza a requisição do CEP ao WebService
		if response.status_code == 200:
			return response.json() # Converte responsta para json
		else:
			return None # Houve algum erro
	except:
		return None # Houve algum erro

#######################################################################################################
#                                                                                                     #
#                                               INIT                                                  #
#                                                                                                     #
#######################################################################################################

# Inicia servidor
if __name__ == "__main__":
    app.run()