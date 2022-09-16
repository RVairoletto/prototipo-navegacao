import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class MenuItensList
{
  static List<DrawerMenuItem> itens = [
    //HomePage
    DrawerMenuItem(
      text: const Text('Home', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      pageRoute: Routes.homePage,
    ),
    //Gerenciar professores
    DrawerMenuItem(
      text: const Text('Professores', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.person, color: Colors.blue),
      pageRoute: Routes.professores,
    ),
    DrawerMenuItem(
      text: const Text('Menu Expandido', style: TextStyle(color: Colors.blue)),
      icon: const Icon(Icons.home, color: Colors.blue),
      //pageRoute: Routes.homePage,
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

class DrawerMenuItem{
  final Text? text;
  final Icon? icon;
  final String pageRoute;
  final List<DrawerMenuItem> children;

  DrawerMenuItem({
    this.text,
    this.icon,
    this.pageRoute = '',
    this.children = const []
  }):assert(
    (children.isEmpty && pageRoute != '')
    || (children.isNotEmpty && pageRoute == '')
  );
}