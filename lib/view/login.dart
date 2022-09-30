import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //controladores das caixas de texto
  final ctrUsuario = TextEditingController();
  final ctrSenha = TextEditingController();

  bool exibirSenha = false;

  ControllerLogin controllerLogin = ControllerLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 500,
              maxHeight: double.infinity,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TextBox de usuário
                TextFormField(
                  controller: ctrUsuario,
                  decoration: const InputDecoration(
                    labelText: "Usuário",
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                //TextBox de senha
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
                      final isLoginValido = await controllerLogin.efetuarLogin(ctrUsuario.text, ctrSenha.text);

                      if(isLoginValido){
                        Navigator.pushReplacementNamed(context, Routes.homePage);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Aviso'),
                              content: const Text('Os dados de login são inválidos'),
                              actions: [
                                TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ok')
                                )
                              ],
                            );
                          }
                        );
                      }
                    },
                    child: const Text("Entrar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
