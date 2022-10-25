import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';
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
      return {
        'error': response.body['error']
      };
    }

    UsuarioAtualModel user = UsuarioAtualModel.fromJson(response.body);
    
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
    // print('resposta da rotina de validação de token: ' +
    //     response.body.toString());
    return true;
  }

  Future<String?> forgotPassword(String email) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'forgotPassword',
      token: '',
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
