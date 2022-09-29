import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';

class ControllerUsuarios {
  //Declaração de variáveis
  String error = '';

  //Autenticar login
  bool autenticarLogin() {
    bool isValido = false;

    //validação

    return isValido;
  }

  //Adicionar usuário
  Future<UsuarioModel?> postMaterial(BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'signup',
      token: '',
      data: usuario.toJson(),
    );

    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }
    return null;
  }

  //Alterar usuário

  //Get usuário
  Map<String, dynamic> getUsuario() {
    Map<String, dynamic> user = {
      'name': '',
      'email': '',
      'password': '',
      'confirmPassword': '',
      'admin': ''
    };

    return user;
  }

  //Get múltiplos usuários

  //Excluir usuário
}