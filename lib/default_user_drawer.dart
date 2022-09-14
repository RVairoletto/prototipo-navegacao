import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/routes.dart';

import 'drawer_menu_items.dart';
import 'menu.dart';

class DefaultUserDrawer extends StatefulWidget {
  const DefaultUserDrawer({ Key? key }) : super(key: key);

  @override
  State<DefaultUserDrawer> createState() => _DefaultUserDrawerState();
}

class _DefaultUserDrawerState extends State<DefaultUserDrawer> {

  @override
  Widget build(BuildContext context) {
    return Menu(
      user: const {
        'profilePicture':'https://picsum.photos/200',
        'name': 'nome',
        'email': 'email'
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
          Navigator.pushReplacementNamed(context, Routes.login);
        },
      ),
    );
  }
}