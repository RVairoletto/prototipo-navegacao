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

  UsuarioModel usuario = UsuarioModel();

  Future<UsuarioModel?> editUsuario(UsuarioModel usuario) async {
    String error = '';

    Map user = usuario.toJson(true);

    user['password'] = '123654ac';
    user.remove('password');

    ApiResponse response = await ApiClient().post(
      endPoint: 'users/edit',
      token: '',
      data: user,
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 204) {
      error = response.body['error'];

      return null;
    }

    return usuario;
  }

  Future<UsuarioModel?> forgotMyPassword(String email) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'users/forgotPassword',
      token: '',
      data: {'email': email},
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode != 204) {
      return null;
    }

    return usuario;
  }

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
              //esqueci minha senha
              ElevatedButton(
                  onPressed: () async {
                    forgotMyPassword('ettsegura@gmail.com');

                    if (ctrUser.error != '') {
                      //deu errado
                      print(ctrUser.error);
                    }
                  },
                  child: const Text('esqueci senha')),
              //edit
              ElevatedButton(
                  onPressed: () async {
                    usuario = await ctrUser.getUsuarioById(2);

                    usuario.name = 'Ettore Segura Costa';

                    editUsuario(usuario);

                    if (ctrUser.error != '') {
                      //deu errado
                      print(ctrUser.error);
                    }
                  },
                  child: const Text('Testar edit usuario')),
              //testando shared preferences
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Teste de shared preferences'),
                            content: Text(
                                prefs.getString('teste') ?? 'não deu certo'),
                          );
                        });
                  },
                  child: const Text('Testar shared preferences')),
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
