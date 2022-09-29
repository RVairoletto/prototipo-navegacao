import 'package:flutter/material.dart';

class UsuariosFormView extends StatefulWidget {
  const UsuariosFormView({super.key});

  @override
  State<UsuariosFormView> createState() => _UsuariosFormViewState();
}

class _UsuariosFormViewState extends State<UsuariosFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Professor"),
      ),
    );
  }
}