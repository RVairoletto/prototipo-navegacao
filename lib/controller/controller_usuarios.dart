import 'dart:io';

class ControllerUsuarios {
  //Declaração de varáveis
  final String backendPath =
      r'D:\Programacao\flutter_projects\prototipo_backend';

  //Autenticar login
  bool autenticarLogin() {
    bool isValido = false;

    if('$backendPath\\api\\auth.js' == ''){

    }

    return isValido;
  }
  //Adicionar usuário

  //Alterar usuário

  //Get usuário
  Map<String, dynamic> getUsuario() {
    Map<String, dynamic> user = {
      'id': '',
      'nome': '',
      'email': '',
      'senha': '',
    };

    return user;
  }

  //Get múltiplos usuários

  //Excluir usuário

}
