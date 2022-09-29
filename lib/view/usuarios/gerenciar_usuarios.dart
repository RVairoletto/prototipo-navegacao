import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class UsuariosView extends StatefulWidget {
  const UsuariosView({super.key});

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciar Usuários"),
        ),
        drawer: const DefaultUserDrawer(),
        body: SizedBox(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.usuariosForm);
              },
              child: const Text("Cadastrar usuário"),
            ),
          ),
        ));
  }
}
