import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

import 'package:email_validator/email_validator.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/usuario_atual.dart';

class ControllerUsuarios {
  //Declaração de variáveis
  final RegExp regExpLetras = RegExp('[a-zA-Z]');
  final RegExp regExpNumeros = RegExp('[0-9]');

  String error = '';

  //Adicionar usuário
  Future<UsuarioModel?> postUsuario(BuildContext context, UsuarioModel usuario) async {
    error = '';

    ApiResponse response = await ApiClient().post(
      endPoint: 'signup',
      token: '',
      data: usuario.toJson(false),
    );
    
    if (response.statusCode != 204) {
      error = response.body['error'];

      return null;
    }
    
    return usuario;
  }

  //Alterar usuário
  Future<UsuarioModel?> putUsuario(BuildContext context, UsuarioModel usuario) async {
    error = '';

    ApiResponse response = await ApiClient().put(
      endPoint: '/users/${usuario.id}',
      token: '',
      data: usuario.toJson(true),
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 204) {
      error = response.body['error'];
      
      return null;
    }
    
    return usuario;
  }

  //Get múltiplos usuários
  Future<List<UsuarioModel>> getUsuarios(BuildContext context) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users',
      token: '',
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    return response.body.map<UsuarioModel>((usuario) => UsuarioModel.fromJson(usuario))
        .toList();
  }

  //Get usuário by id
  Future<UsuarioModel> getUsuarioById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users/$id',
      token: '',
    );

    if(response.statusCode != 200){
      throw Exception(response.body['error']);
    }

    UsuarioModel user = UsuarioModel.fromJson(response.body);

    return user;
  }

  //Excluir usuário
  Future<bool> deleteUsuario(BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'users/disable',
      token: '',
      data: {
        'id': usuario.id,
        'disabled': true
      }
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 204) {
      return false;
    }

    return true;
  }

  //Validar Senha
  String validarSenha(String senha) {
    if (senha.length < 8) {
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
  String validarCadastro(String usuario, String email, String senha, String confirmarSenha,) {
    String msgErro = '';

    if (usuario == '') {
      msgErro = 'Insira um nome de usuário\n';
    }
    
    if (email == '') {
      msgErro += 'Insira um e-mail\n';
    } else if (!EmailValidator.validate(email)) {
      msgErro += 'Insira um e-mail válido\n';
    }

    msgErro += validarSenha(senha);
    
    if (senha != confirmarSenha) {
      msgErro += '\nAs senhas devem ser iguais';
    }

    if (!regExpLetras.hasMatch(senha)) {
      msgErro += '\nA senha deve conter ao menos uma letra';
    }

    if (!regExpNumeros.hasMatch(senha)) {
      msgErro += '\nA senha deve conter ao menos um número';
    }

    return msgErro;
  }

  //Alterar Senha
  alterarSenha(UsuarioAtualModel usuarioAtual, String senhaNova) async {
    error = '';

    ApiResponse response = await ApiClient().post(
      endPoint: 'users/newPassword',
       token: '',
       data: {
        'id': usuarioAtual.id,
        'password': senhaNova
       }
    );

    if (response.statusCode != 204) {
      error += 'Não foi possível alterar sua senha';
    }
  }
}
