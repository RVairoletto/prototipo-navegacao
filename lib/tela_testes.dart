import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/model/usuario.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api_client.dart';
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
    ControllerUsuarios ctrUser = ControllerUsuarios();
    return Scaffold(
        drawer: const DefaultUserDrawer(),
        appBar: AppBar(title: const Text("Tela de testes")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //get user by id
              ElevatedButton(
                onPressed: () async {
                  final user = ctrUser.getUsuarioById(1);
                  if(user.runtimeType != UsuarioModel){
                    //não achou
                  }
                },
                child: const Text('Testar get user by id')
              ),
              //testando shared preferences
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: const Text('Teste de shared preferences'),
                      content: Text(prefs.getString('teste') ?? 'não deu certo'),
                    );
                  }
                  );
                },
                child: const Text('Testar shared preferences')
              ),
              //
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
            ],
          ),
        ));
  }
}
