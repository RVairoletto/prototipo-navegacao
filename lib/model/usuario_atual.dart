import 'package:prototipo_navegacao/model/usuario.dart';

class UsuarioAtualModel extends UsuarioModel{
  String token;

  UsuarioAtualModel({
    this.token = '',
    id,
    name,
    email,
    password,
    admin,
    disabled,
  }) : super (
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
      'email': email,
      'password': password,
      'admin': admin,
      'disabled': disabled
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
      disabled: json['disabled']
    );
  }
}
