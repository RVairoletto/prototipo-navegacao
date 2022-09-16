import 'package:flutter/material.dart';

class Modal extends StatefulWidget {
  const Modal({super.key});

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text("Você tem certeza\nque deseja realizar\nessa operação?"),
        buttonPadding: const EdgeInsets.symmetric(horizontal: 25),
        actions: [
          //ok
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Confirmar"),
          ),
          //cancelar
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
        ],
      )
    );
  }
}

// bool value = await Navigator.push(context, MaterialPageRoute<bool>(
//   builder: (BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         child: Text('OK'),
//         onTap: () { Navigator.pop(context, true); }
//       ),
//     );
//   }
// ));