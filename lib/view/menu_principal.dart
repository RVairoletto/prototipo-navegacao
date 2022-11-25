import 'package:flutter/material.dart';

import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class MenuPrincipalView extends StatefulWidget {
  const MenuPrincipalView({Key? key}) : super(key: key);

  @override
  State<MenuPrincipalView> createState() => _MenuPrincipalViewState();
}

//View de menu principal
class _MenuPrincipalViewState extends State<MenuPrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DefaultUserDrawer(),
      body: SizedBox(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                //Texto de boas vindas
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 50),
                  child: Text(
                    "Olá, bem vindo\nao sistema",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 48,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
