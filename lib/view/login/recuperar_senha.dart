import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/util/routes.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

//View de recuperação de senha
class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  TextEditingController ctrEmail = TextEditingController();

  ControllerLogin ctrLogin = ControllerLogin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar Senha'),
      ),
      body: Center(
        child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
          //Coluna com tudo
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                //Textfield de email
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    autofocus: true,
                    controller: ctrEmail,
                    decoration: const InputDecoration(
                      label: Text('E-mail')
                    ),
                  ),
                ),
                //Linha com os botões de cancelar e confirmar
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Botão de cancelar
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushReplacementNamed(context, Routes.login);
                          },
                          child: const Text('Cancelar')
                        ),
                      ),
                      //Botão de confirmar
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            //Validar e-mail
                            if(!EmailValidator.validate(ctrEmail.text)){
                              //Aviso de e-mail inválido
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Aviso'),
                                    content: const Text('Insira um e-mail válido'),
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
                            
                            final String? respForgotPassword = await ctrLogin.forgotPassword(ctrEmail.text);

                            if(respForgotPassword == null){
                              //A requisição foi bem sucedida
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Sucesso'),
                                    content: const Text('Confira seu e-mail'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacementNamed(context, Routes.login);
                                        },
                                        child: const Text('Ok')
                                      )
                                    ],
                                  );
                                }
                              );
                            } else {
                              //Não foi possível alterar a senha
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Aviso'),
                                    content: Text(respForgotPassword),
                                    actions: [
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
                          },
                          child: const Text('Confirmar')
                        ),
                      ),
                    ],
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
