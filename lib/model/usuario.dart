class UsuarioModel {
  int? id;
  String name;
  String email;
  String password;
  bool admin;

  UsuarioModel({
    this.id,
    this.name = '',
    this.email = '',
    this.password = '',
    this.admin = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'admin': admin,
    };
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      admin: json['admin'],
    );
  }
}
