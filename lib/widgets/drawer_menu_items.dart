import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class MenuItensList {
  static List<DrawerMenuItem> itens = [
    //HomePage
    DrawerMenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      pageRoute: Routes.homePage,
    ),
    //Gerenciar usuários
    DrawerMenuItem(
      text: const Text('Usuários', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.usuarios,
    ),
    //Gerenciar níveis de acesso
    DrawerMenuItem(
      text: const Text('Níveis de Acesso', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.arrow_upward_sharp, color: Colors.blue),
      pageRoute: Routes.niveisAcesso,
    ),
    //Gerenciar professores
    DrawerMenuItem(
      text: const Text('Professores', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.professores,
    ),
    //Gerenciar Disciplinas
    DrawerMenuItem(
      text: const Text('Disciplinas', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.disciplinas,
    ),
    //Alterar senha
    DrawerMenuItem(
      text: const Text('Alterar Senha', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.alterarSenha,
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

  static List<DrawerMenuItem> analistaItens = [
    //HomePage
    DrawerMenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      pageRoute: Routes.homePage,
    ),
    //Gerenciar usuários
    DrawerMenuItem(
      text: const Text('Usuários', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.usuarios,
    ),
    //Gerenciar professores
    DrawerMenuItem(
      text: const Text('Professores', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.professores,
    ),
    //Gerenciar Disciplinas
    DrawerMenuItem(
      text: const Text('Disciplinas', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.disciplinas,
    ),
    //Alterar senha
    DrawerMenuItem(
      text: const Text('Alterar Senha', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.alterarSenha,
    ),
  ];
}

class DrawerMenuItem {
  final Text? text;
  final Icon? icon;
  final String pageRoute;
  final List<DrawerMenuItem> children;

  DrawerMenuItem({
    this.text,
    this.icon,
    this.pageRoute = '',
    this.children = const []
  }) : assert (
    (children.isEmpty && pageRoute != '') || (children.isNotEmpty && pageRoute == '')
  );
}
