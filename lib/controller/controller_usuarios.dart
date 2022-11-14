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
  Future<UsuarioModel?> postUsuario(UsuarioModel usuario) async {
    error = '';

    ApiResponse response = await ApiClient().post(
      endPoint: 'signup',
      token: '',
      data: usuario.toJson(false),
    );

    if (response.statusCode != 204) {
      error = response.body['error'] ?? 'Não foi possível salvar seu cadastro';

      return null;
    }

    return usuario;
  }

  void editUsuario(UsuarioModel usuario) async {
    error = '';

    Map user = usuario.toJson(true);

    user.remove('password');

    ApiResponse response = await ApiClient().post(
      endPoint: 'users/edit',
      token: '',
      data: user,
    );

    if (response.statusCode != 204) {
      error += response.body['error'] ?? 'Não foi possível alterar o usuário';
    }
  }

  //Get múltiplos usuários
  Future<List<UsuarioModel>> getUsuarios() async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users',
      token: '',
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    return response.body
        .map<UsuarioModel>((usuario) => UsuarioModel.fromJson(usuario))
        .toList();
  }

  //Get usuário by id
  Future<UsuarioModel> getUsuarioById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users/$id',
      token: '',
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error']);
    }

    UsuarioModel user = UsuarioModel.fromJson(response.body[0]);

    return user;
  }

  //Desabilitar usuário
  Future<bool> disableUsuario(UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().post(
        endPoint: 'users/disable',
        token: '',
        data: {'id': usuario.id, 'disabled': true}
      );

    if (response.statusCode != 204) {
      return false;
    }

    return true;
  }

  //Buscar níveis de acesso
  Future<List<dynamic>> getNiveisAcesso(int userId) async {
    ApiResponse response = await ApiClient().get(
        endPoint: 'userLevel/$userId',
      );

    if (response.statusCode != 200) {
      throw Exception(response.body['error'] ?? 'Não foi possível buscar os níveis de acesso do usuário');
    }

    List<dynamic> retorno = response.body.toList();

    return retorno;
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
  String validarCadastro(
    String usuario,
    String email,
    String senha,
    String confirmarSenha,
  ) {
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
        data: {'id': usuarioAtual.id, 'password': senhaNova});

    if (response.statusCode != 204) {
      error += 'Não foi possível alterar sua senha';
    }
  }
}
