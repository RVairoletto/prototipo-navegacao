import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

import 'api/api_response.dart';

class TestesView extends StatefulWidget {
  const TestesView({super.key});

  @override
  State<TestesView> createState() => _TestesViewState();
}

class _TestesViewState extends State<TestesView> {
  Color corContainer = Colors.yellow;
  Map<String, dynamic> parametros = {
    "name": "Ettore",
    "email": "ettsegura@gmail.com",
    "password": "123456",
    "confirmPassword": "123456",
    "admin": 'true'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DefaultUserDrawer(),
        appBar: AppBar(title: const Text("Tela de testes")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) {
                      return const DefaultAlertDialog();
                    },
                  );

                  setState(() {
                    if (result) {
                      corContainer = Colors.green;
                    } else {
                      corContainer = Colors.red;
                    }
                  });
                },
                child: const Text("Mostrar modal"),
              ),
              Container(
                width: 300,
                height: 300,
                color: corContainer,
              ),
              ElevatedButton(
                onPressed: () async {
                  ApiResponse response = await ApiClient().post(
                    endPoint: 'signup',
                    token: '',
                    data: parametros,
                  );

                  print(response.statusCode);
                },
                child: const Text("Get api"),
              )
            ],
          ),
        ));
  }
}
