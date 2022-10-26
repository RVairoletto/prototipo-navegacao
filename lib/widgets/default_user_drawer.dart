import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drawer_menu_items.dart';
import 'menu.dart';

class DefaultUserDrawer extends StatefulWidget {
  const DefaultUserDrawer({ Key? key }) : super(key: key);

  @override
  State<DefaultUserDrawer> createState() => _DefaultUserDrawerState();
}

class _DefaultUserDrawerState extends State<DefaultUserDrawer> {
  SharedPreferences? prefs;

  getPreferences() async{
    prefs = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Menu(
      user: prefs == null ? {
        'profilePicture':'https://picsum.photos/200',
        'name': 'Nome',
        'email': 'Email',
      } : {
        'profilePicture':'https://picsum.photos/200',
        'name': jsonDecode(prefs!.getString('usuario_atual')?? '')['name'],
        'email': jsonDecode(prefs!.getString('usuario_atual')?? '')['email'],
      },
      pages: MenuItensList.itens,
      footer: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 70)),
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
          await prefs!.clear().then((value) => Navigator.pushReplacementNamed(context, Routes.login));
        },
      ),
    );
  }
}