import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';

class ControllerLogin {
  //Efetuar login
  Future<Map<String, dynamic>> efetuarLogin(
      BuildContext context, Map<String, String> dadosLogin) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'signin',
      token: '',
      data: dadosLogin
    );
    
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    Map<String, dynamic> retorno = jsonDecode(response.body);
    retorno['statusCode'] = response.statusCode;
    
    return retorno;
  }

  Future<bool> validarToken(Map<String, dynamic> token) async {
    ApiResponse response = await ApiClient()
        .post(endPoint: 'validateToken', token: '', data: token);
    //confirmar códigos de sucesso e erro
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    //confirmar
    print('resposta da rotina de validação de token: ' +
        response.body.toString());
    return true;
  }
}
