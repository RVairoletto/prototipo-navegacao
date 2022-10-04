import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/model/usuario.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ctrUsuario = TextEditingController();
  final ctrSenha = TextEditingController();

  ControllerUsuarios ctrUsuarios = ControllerUsuarios();
  ControllerLogin controllerLogin = ControllerLogin();
  List<UsuarioModel> usuarios = [];

  fetchUsuarios() async {
    usuarios = await ctrUsuarios.getUsuario(context);
  }

  @override
  void initState() {
    fetchUsuarios();
    super.initState();
  }

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
                      Map<String, String> dadosLogin = {
                        'email' : ctrUsuario.text,
                        'senha': ctrSenha.text,
                      };

                      final isLoginValido = await controllerLogin.efetuarLogin(
                        context, dadosLogin);

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
                //Autologin pra testes
                ElevatedButton(
                  onPressed: (() => Navigator.pushReplacementNamed(context, Routes.homePage)),
                  child: const Text('Autologin')
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
