import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/controller/controller_permissions.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';
import 'package:prototipo_navegacao/model/permissions.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drawer_menu_items.dart';
import 'menu.dart';

class DefaultUserDrawer extends StatefulWidget {
  const DefaultUserDrawer({Key? key}) : super(key: key);

  @override
  State<DefaultUserDrawer> createState() => _DefaultUserDrawerState();
}

class _DefaultUserDrawerState extends State<DefaultUserDrawer> {
  SharedPreferences? prefs;

  List<DrawerMenuItem> menuItems = [];

  fetchPreferences() async {
    prefs = await SharedPreferences.getInstance();

    fetchPermissions();

    setState(() {
      //
    });
  }

  fetchPermissions() async {
    ControllerPermissions ctrPermissions = ControllerPermissions();
    ControllerUsuarios ctrUser = ControllerUsuarios();

    List<dynamic> niveisAcesso = await ctrUser.getNiveisAcesso(jsonDecode(prefs!.getString('usuario_atual') ?? '')['id']);

    List<Permission> listPermissions = [];

    for(int i = 0; i < niveisAcesso.length; i++){
      listPermissions.addAll(await ctrPermissions.getPermissions(niveisAcesso[i]['id']));
    }

    for(int i = 0; i < MenuItemsList.itens.length; i++){
      for(int x = 0; x < listPermissions.length; x++){
        if(MenuItemsList.itens[i].description == listPermissions[x].description){
          menuItems.add(MenuItemsList.itens[i]);

          break;
        }
      }
    }

    //menuItems.addAll(MenuItemsList.itens);
    
    setState(() {
      //
    });
  }

  @override
  void initState() {
    fetchPreferences();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Menu(
      user: prefs == null
          ? {
              'profilePicture': 'https://picsum.photos/200',
              'name': 'Nome',
              'email': 'Email'
            }
          : {
              'profilePicture': 'https://picsum.photos/200',
              'name':
                  jsonDecode(prefs!.getString('usuario_atual') ?? '')['name'],
              'email':
                  jsonDecode(prefs!.getString('usuario_atual') ?? '')['email'],
            },
      pages: menuItems,
      footer: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 70)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.logout, color: Colors.blue),
            ),
            //Botão de logout
            Container(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
        onPressed: () async {
          await prefs!.clear().then(
              (value) => Navigator.pushReplacementNamed(context, Routes.login));
        },
      ),
    );
  }
}
