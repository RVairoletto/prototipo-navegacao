import 'package:prototipo_navegacao/model/usuario.dart';

class UsuarioAtualModel extends UsuarioModel{
  int? id;
  String token;
  String name;
  String email;
  String password;
  bool admin;

  UsuarioAtualModel({
    this.id,
    this.token = '',
    this.name = '',
    this.email = '',
    this.password = '',
    this.admin = false,
  });

  Map<String, dynamic> toJson(bool serializeId) {
    Map<String, dynamic> retorno = {
      'name': name,
      'email': email,
      'password': password,
      'admin': admin,
    };

    if (serializeId) {
      retorno['id'] = id;
    }

    return retorno;
  }

  factory UsuarioAtualModel.fromJson(Map<String, dynamic> json) {
    return UsuarioAtualModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: (json['password']) != null ? json['password'] : null,
      admin: json['admin'],
    );
  }
}
