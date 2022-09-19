import 'package:flutter/material.dart';

//função pra testar a possibilidade de exibir a modal de confirmação
//sem ela obscurecer completamente o que tá atrás dela
void mostrarModal(BuildContext context, String texto) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(texto),
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
    },
  );

  return Navigator.pop(context, true);
}
