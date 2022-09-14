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
      drawer: DefaultUserDrawer(),
      appBar: AppBar(),
      body: SizedBox(
        //
      )
    );
  }
}
