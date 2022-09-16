import 'package:flutter/material.dart';

class ProfessoresFormView extends StatefulWidget {
  const ProfessoresFormView({super.key});

  @override
  State<ProfessoresFormView> createState() => _ProfessoresFormViewState();
}

class _ProfessoresFormViewState extends State<ProfessoresFormView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Professor"),
      ),
      body: SizedBox(
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}