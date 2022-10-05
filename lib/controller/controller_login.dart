import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';

class ControllerLogin {
  //Efetuar login
  Future<bool> efetuarLogin(
      BuildContext context, Map<String, String> dadosLogin) async {
    ApiResponse response =
        await ApiClient().post(endPoint: 'signin', token: '', data: dadosLogin);

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    //confirmar retorno do signin
    Map<String, dynamic> retorno = jsonDecode(response.body);

    if (retorno.containsKey('token')) {
      return true;
    }

    return false;
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
