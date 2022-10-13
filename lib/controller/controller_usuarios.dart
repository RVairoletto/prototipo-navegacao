import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

import 'package:email_validator/email_validator.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../model/usuario_atual.dart';
import '../util/routes.dart';
import '../widgets/default_alert_dialog.dart';

class ControllerUsuarios {
  //Declaração de variáveis
  final RegExp regExpLetras = RegExp('[a-zA-Z]');
  final RegExp regExpNumeros = RegExp('[0-9]');

  String error = '';

  //Adicionar usuário
  Future<UsuarioModel?> postUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'signup',
      token: '',
      data: usuario.toJson(false),
    );
    
    //confirmar códigos de sucesso e erro
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
  Future<UsuarioModel?> putUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().put(
      endPoint: '', //endpoint pendente
      token: '',
      data: usuario.toJson(false),
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }

    return null;
  }

  //Get múltiplos usuários
  Future<List<UsuarioModel>> getUsuario(BuildContext context) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users',
      token: '',
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    //pendente de testes
    return response.body['data']['rows']
        .map<UsuarioModel>((material) => UsuarioModel.fromJson(material))
        .toList();
  }

  //Get usuário

  //Excluir usuário
  Future<UsuarioModel?> deleteUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().delete(
      endPoint: '', //endpoint pendente
      token: '',
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }

    return null;
  }

  //Gerar datatable
  DataRow gerarDataRow(BuildContext context, UsuarioModel? usuario) {
    return DataRow(cells: [
      DataCell(Text(usuario!.name)),
      DataCell(Text(usuario.email)),
      DataCell(IconButton( //Alterar
        icon: const Icon(Icons.app_registration),
        onPressed: () {
          Navigator.pushNamed(context, Routes.usuariosForm);
        },
      )),
      DataCell(IconButton( //Excuir
        icon: const Icon(Icons.remove_circle),
        onPressed: () async {
          final confirmarExclusao = await showDialog(
            context: context,
            builder: (context) {
              return const DefaultAlertDialog();
            },
          );

          if (confirmarExclusao) {
            deleteUsuario(context, usuario);
          }
        },
      )),
    ]);
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

  //Alterar Senha
  Future<UsuarioModel?> alterarSenha(
    UsuarioAtualModel usuarioAtual, String senhaNova) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'users/newPassword',
       token: '',
       data: {
        'id': usuarioAtual.id,
        'password': usuarioAtual.password
       }
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    //pendente de testes
    if(response.body['error'] != ''){
      return UsuarioAtualModel.fromJson(jsonDecode(response.body));
    }

    //pendente de testes
    // return response.body.map<UsuarioModel>((usuario) => UsuarioModel.fromJson(usuario));

    return null;
  }
}
