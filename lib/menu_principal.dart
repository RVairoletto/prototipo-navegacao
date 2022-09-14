import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/default_user_drawer.dart';

class MenuPrincipalView extends StatefulWidget {
  const MenuPrincipalView({Key? key}) : super(key: key);

  @override
  State<MenuPrincipalView> createState() => _MenuPrincipalViewState();
}

class _MenuPrincipalViewState extends State<MenuPrincipalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DefaultUserDrawer(),
      appBar: AppBar(),
      body: SizedBox(
        child: Column(
          children: [
            Row(
              children: [
                //Texto de boas vindas
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 50),
                  child: Text(
                    "Olá, bem vindo\nAo sistema",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 48,
                    ),
                  ),
                ),
                Container(
                  color: Colors.green
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}
