import 'package:prototipo_navegacao/model/usuario.dart';

class UsuarioAtualModel extends UsuarioModel {
  String token;
  int exp;
  int iat;

  UsuarioAtualModel({
    this.token = '',
    this.exp = 0,
    this.iat = 0,
    id,
    name,
    email,
    password,
    admin,
    disabled,
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
    admin: admin,
    disabled: disabled,
  );

  @override
  Map<String, dynamic> toJson(bool serializeId) {
    Map<String, dynamic> retorno = {
      'name': name,
      'token': token,
      'email': email,
      'password': password,
      'admin': admin,
      'disabled': disabled,
      'exp': exp,
      'iat': iat,
    };

    if (serializeId) {
      retorno['id'] = id;
    }

    return retorno;
  }

  factory UsuarioAtualModel.fromJson(Map<String, dynamic> json) {
    return UsuarioAtualModel(
      id: json['id'],
      token: json['token'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: (json['password']) != null ? json['password'] : '',
      admin: json['admin'] ?? false,
      disabled: json['disabled'] ?? false,
      exp: json['exp'] ?? 0,
      iat: json['iat'] ?? 0
    );
  }
}
