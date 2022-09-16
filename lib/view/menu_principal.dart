import 'package:flutter/material.dart';

import '../widgets/default_user_drawer.dart';

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
                mainAxisSize: MainAxisSize.min,
                children: [
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
        ));
  }
}
