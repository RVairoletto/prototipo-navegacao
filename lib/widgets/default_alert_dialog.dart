import 'package:flutter/material.dart';

class DefaultAlertDialog extends StatefulWidget {
  const DefaultAlertDialog({super.key});

  @override
  State<DefaultAlertDialog> createState() => _DefaultAlertDialogState();
}

class _DefaultAlertDialogState extends State<DefaultAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Aviso"),
      content: const Text("Você tem certeza que deseja realizar essa ação?"),
      actions: [
        //botão de confirmar
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text("Confirmar"),
        ),
        //botão de cancelar
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text("Cancelar"),
        ),
      ],
    );
  }
}