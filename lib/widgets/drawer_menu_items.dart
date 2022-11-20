import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class MenuItemsList {
  static List<DrawerMenuItem> itens = [
    //HomePage
    DrawerMenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      pageRoute: Routes.homePage,
      description: 'homepage',
    ),
    //Gerenciar usuários
    DrawerMenuItem(
      text: const Text('Usuários', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.usuarios,
      description: 'usuarios',
    ),
    //Gerenciar níveis de acesso
    DrawerMenuItem(
      text: const Text('Níveis de Acesso', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.arrow_upward_sharp, color: Colors.blue),
      pageRoute: Routes.niveisAcesso,
      description: 'niveisacesso',
    ),
    //Gerenciar professores
    DrawerMenuItem(
      text: const Text('Professores', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.professores,
      description: 'professores',
    ),
    //Gerenciar Disciplinas
    DrawerMenuItem(
      text: const Text('Disciplinas', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.disciplinas,
      description: 'disciplinas',
    ),
    //Alterar senha
    DrawerMenuItem(
      text: const Text('Alterar Senha', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.alterarSenha,
      description: 'alterarsenha',
    ),
    //Tela de testes
    DrawerMenuItem(
      text: const Text('Testes', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.telaTestes,
    ),
    DrawerMenuItem(
      text: const Text('Menu Expandido', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      children: [
        DrawerMenuItem(
          text: const Text('sub item 1', style: TextStyle(color: Colors.blue)),
          icon: const Icon(Icons.home, color: Colors.blue),
          pageRoute: Routes.homePage,
        ),
        DrawerMenuItem(
          text: const Text('sub item 2', style: TextStyle(color: Colors.blue)),
          icon: const Icon(Icons.home, color: Colors.blue),
          pageRoute: Routes.homePage,
        ),
      ]
    ),
  ];
}

class DrawerMenuItem {
  final int? id;
  final Text? text;
  final Icon? icon;
  final String pageRoute;
  final String description;
  final List<DrawerMenuItem> children;

  DrawerMenuItem({
    this.id,
    this.text,
    this.icon,
    this.pageRoute = '',
    this.description = '',
    this.children = const []
  }) : assert (
    (children.isEmpty && pageRoute != '') || (children.isNotEmpty && pageRoute == '')
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> retorno = {
      'text': text?.data,
      'pageroute': pageRoute,
      'description': description,
    };

    return retorno;
  }

  factory DrawerMenuItem.fromJson(Map<String, dynamic> json) {
    return DrawerMenuItem(
      id: json['id'],
      text: Text(json['text'] ?? 'MenuItem'),
      //icon: json['icon'],
      pageRoute: json['pageroute'],
      description: json['description'],
      //children: json['children'],
    );
  }
}
