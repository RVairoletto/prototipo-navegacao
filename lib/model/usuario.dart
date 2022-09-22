import 'dart:math';

import 'package:flutter/material.dart';

class Usuario {
  int? id;
  String nome;
  String email;
  String senha;

  Usuario({
    this.id,
    this.nome = '',
    this.email = '',
    this.senha = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
    );
  }
}
