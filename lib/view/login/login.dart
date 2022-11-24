import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/controller/controller_menus.dart';
import 'package:prototipo_navegacao/model/usuario_atual.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

//View de login
class _LoginViewState extends State<LoginView> {
  final ctrUsuario = TextEditingController();
  final ctrSenha = TextEditingController();

  ControllerLogin controllerLogin = ControllerLogin();
  ControllerMenus controllerMenus = ControllerMenus();

  bool exibirSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login")
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: double.infinity,
            ),
            //Coluna com tudo
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Textfield de usuário
                TextFormField(
                  autofocus: true,
                  controller: ctrUsuario,
                  decoration: const InputDecoration(
                    labelText: "Usuário",
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                //Textfield de senha
                TextFormField(
                  controller: ctrSenha,
                  obscureText: !exibirSenha,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.lock_rounded),
                    suffixIcon: InkWell(
                      onTap: () => setState(
                        () => exibirSenha = !exibirSenha,
                      ),
                      child: Icon(
                        exibirSenha
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                        color: const Color(0xFF757575),
                      ),
                    ),
                  ),
                ),
                //Botão de login
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () async {
                      //Validação de dados de entrada
                      String msgErro = '';

                      if (ctrUsuario.text == '') {
                        msgErro = 'Digite um email';
                      } else if (ctrSenha.text == '') {
                        msgErro = 'Digite uma senha';
                      }

                      if (msgErro != '') {
                        //Janela de aviso
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Aviso'),
                              content: Text(msgErro),
                              actions: [
                                //Botão de ok
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok')
                                )
                              ],
                            );
                          }
                        );
                        
                        return;
                      }

                      Map<String, String> dadosLogin = {
                        'email': ctrUsuario.text,
                        'password': ctrSenha.text,
                      };

                      final retornoLogin = await controllerLogin.efetuarLogin(context, dadosLogin);

                      //Login bem sucedido
                      if(retornoLogin.containsKey('user')) {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        //Salvar instância de usuário atual
                        UsuarioAtualModel user = retornoLogin['user'];
                        prefs.setString('usuario_atual', jsonEncode(user.toJson(true))).then((value) {
                          Navigator.pushReplacementNamed(context, Routes.homePage);
                        });
                      } else {
                        //Aviso de login mal sucedido
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Aviso'),
                              content: Text(retornoLogin['error']),
                              actions: [
                                //Botão de ok
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok')
                                )
                              ],
                            );
                          }
                        );
                      }

                      return;
                    },
                    child: const Text("Entrar"),
                  ),
                ),
                //Esqueci minha senha
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.recuperarSenha);
                    },
                    child: const Text('Esqueci minha senha')
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
