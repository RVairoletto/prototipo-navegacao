import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/api/api_client.dart';

class ControllerLogin {
  final RegExp regExpLetras = RegExp('[a-zA-Z]');
  final RegExp regExpNumeros = RegExp('[0-9]');

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
    Map<String, dynamic> retorno = response.body;

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

  //Validar Senha
  String validarSenha(String? senha) {
    if (senha!.length < 8) {
      return 'A senha deve conter pelo menos 8 caracteres';
    }

    if (!regExpLetras.hasMatch(senha)) {
      return 'A senha deve conter pelo menos uma letra';
    }

    if (!regExpNumeros.hasMatch(senha)) {
      return 'A senha deve conter pelo menos um número';
    }

    return '';
  }

  //Validar dados de cadastro
  String validarCadastro(
      String usuario, String email, String senha, String confirmarSenha) {
    String msgErro = '';

    if (usuario == '') {
      msgErro = 'Insira um nome de usuário\n';
    }

    if (email == '') {
      msgErro += 'Insira um e-mail\n';
    } else if (!EmailValidator.validate(email)) {
      msgErro += 'Insira um e-mail válido\n';
    }
    if (senha == '') {
      msgErro += 'Insira uma senha\n';
    } else if (senha.length < 8) {
      msgErro += 'A senha deve ter ao menos 8 caracteres\n';
    }
    if (senha != confirmarSenha) {
      msgErro += 'As senhas devem ser iguais\n';
    }

    if (!regExpLetras.hasMatch(senha)) {
      msgErro += 'A senha deve conter ao menos uma letra\n';
    }

    if (!regExpNumeros.hasMatch(senha)) {
      msgErro += 'A senha deve conter ao menos um número';
    }

    return msgErro;
  }
}
