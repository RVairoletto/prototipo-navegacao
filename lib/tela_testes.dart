import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class TestesView extends StatefulWidget {
  const TestesView({super.key});

  @override
  State<TestesView> createState() => _TestesViewState();
}

//Tela criada para testes de componentes e rotinas
class _TestesViewState extends State<TestesView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: const DefaultUserDrawer(),
      appBar: AppBar(title: const Text("Tela de testes")),
    );
  }
}
