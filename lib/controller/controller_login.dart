import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/model/usuario.dart';
import 'package:prototipo_navegacao/model/usuario_atual.dart';

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
      //throw Exception(response.body['error']);
      return {
        'error': response.body['error']
      };
    }
    UsuarioModel user = UsuarioModel();

    user.id = response.body['id'];
    user.name = response.body['name'];
    user.email = response.body['email'];
    user.password = dadosLogin['password'] ?? '';
    user.admin = response.body['admin'];
    user.disabled = false;
    
    return {
      'user': user
    };
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
