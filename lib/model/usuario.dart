class UsuarioModel {
  int? id;
  String name;
  String email;
  String password;
  bool admin;
  bool disabled;

  UsuarioModel({
    this.id,
    this.name = '',
    this.email = '',
    this.password = '',
    this.admin = false,
    this.disabled = false,
  });

  Map<String, dynamic> toJson(bool serializeId) {
    Map<String, dynamic> retorno = {
      'name': name,
      'email': email,
      'password': password,
      'admin': admin,
      'disabled': disabled,
    };

    if (serializeId) {
      retorno['id'] = id;
    }

    return retorno;
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: (json['password']) ?? '',
      admin: json['admin'] ?? false,
      disabled: (json['disabled'] ?? false),
    );
  }
}
