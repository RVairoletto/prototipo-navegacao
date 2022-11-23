import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/model/usuario_atual.dart';

//Classe de controller responsável pelas operações de login
class ControllerLogin {
  //Efetuar login
  Future<Map<String, dynamic>> efetuarLogin(BuildContext context, Map<String, String> dadosLogin) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'signin',
      data: dadosLogin
    );
    
    if (response.statusCode != 200) {
      return {
        'error': response.body['error'] ?? 'Não foi possível efetuar o login'
      };
    }

    UsuarioAtualModel user = UsuarioAtualModel.fromJson(response.body);
    
    return {
      'user': user
    };
  }

  //Esqueci minha senha
  Future<String?> forgotPassword(String email) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'forgotPassword',
      data: {
        'email': email
      }
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível recuperar sua senha';
    }

    return null;
  }
}
