import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ctrUsuario = TextEditingController();
  final ctrSenha = TextEditingController();

  ControllerLogin controllerLogin = ControllerLogin();

  bool exibirSenha = false;

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
                        String msgErro = '';

                        if (ctrUsuario.text == '') {
                          msgErro = 'Digite um email';
                        } else if (ctrSenha.text == '') {
                          msgErro = 'Digite uma senha';
                        }

                        if (msgErro != '') {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Aviso'),
                                  content: Text(msgErro),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'))
                                  ],
                                );
                              });
                          return;
                        }

                        Map<String, String> dadosLogin = {
                          'email': ctrUsuario.text,
                          'password': ctrSenha.text,
                        };

                        final retornoLogin = await controllerLogin.efetuarLogin(
                            context, dadosLogin);

                        if (retornoLogin['statusCode'] == '200') {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'usuario_atual', retornoLogin.toString());
                          Navigator.pushReplacementNamed(
                              context, Routes.homePage);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Aviso'),
                                  content: Text(retornoLogin['error']),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'))
                                  ],
                                );
                              });
                        }

                        return;
                      },
                      child: const Text("Entrar"),
                    ),
                  ),
                  //Autologin pra testes
                  ElevatedButton(
                      onPressed: (() async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('teste', 'valor de teste');
                        Navigator.pushReplacementNamed(
                            context, Routes.homePage);
                      }),
                      child: const Text('Autologin')),
                  //Esqueci minha senha
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.recuperarSenha);
                        },
                        child: const Text('Esqueci minha senha')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
