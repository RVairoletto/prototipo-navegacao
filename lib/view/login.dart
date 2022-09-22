import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //controladores das caixas de texto
  final _ctrUsuario = TextEditingController();
  final _ctrSenha = TextEditingController();
  bool exibirSenha = false;
  final String backendPath = r'D:\Programacao\flutter_projects\prototipo_backend';

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
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TextBox de usuário
                TextFormField(
                  controller: _ctrUsuario,
                  decoration: const InputDecoration(
                    labelText: "Usuário",
                    prefixIcon: Icon(Icons.person_rounded),
                  ),
                ),
                //TextBox de senha
                TextFormField(
                  controller: _ctrSenha,
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
                    onPressed: () {
                      if (_ctrUsuario.text == "exemplo@email.com" &&
                          _ctrSenha.text == "123") {
                        Navigator.of(context).pushReplacementNamed(Routes.homePage);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context){
                            return const AlertDialog(
                              title: Text('Algo deu errado'),
                              content: Text('Verifique os dados de login'),
                            );
                          },
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
