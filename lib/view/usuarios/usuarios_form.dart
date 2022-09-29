import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';

class UsuariosFormView extends StatefulWidget {
  const UsuariosFormView({super.key});

  @override
  State<UsuariosFormView> createState() => _UsuariosFormViewState();
}

class _UsuariosFormViewState extends State<UsuariosFormView> {
  TextEditingController ctrNomeUsuario = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrSenha = TextEditingController();
  TextEditingController ctrConfirmarSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar Usuário"),
        ),
        body: SizedBox(
          //Coluna com tudo da tela
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Linha com os campos de nome e email
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Campo de nome de usuário
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autofocus: true,
                              controller: ctrNomeUsuario,
                              decoration: const InputDecoration(
                                  label: Text("Nome de Usuário")),
                            ),
                          ),
                        ),
                        //Campo de email
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ctrEmail,
                              decoration:
                                  const InputDecoration(label: Text("E-mail")),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Linha com os campos de senha e confirmar senha
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //Campo de senha
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: ctrSenha,
                                decoration:
                                    const InputDecoration(label: Text("Senha")),
                              ),
                            ),
                          ),
                          //Campo de confirmar senha
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: ctrConfirmarSenha,
                                /* validator: (value) {
                                  return (ctrConfirmarSenha.text != ctrSenha.text) ? 'Os campos devem ser iguais' : null;
                                }, */
                                //Evento que vai verificar se esse campo é igual ao campo da senha
                                onChanged: (text) {
                                  if (ControllerUsuarios.senhasIguais(
                                      ctrSenha.text, ctrConfirmarSenha.text)) {
                                    //senhas iguais
                                  } else {}
                                },
                                decoration: const InputDecoration(
                                    label: Text("Confirmar senha")),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Botões de confirmar e cancelar
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Botão de cancelar
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.cancel),
                          iconSize: 90,
                          splashRadius: 45,
                          onPressed: (() {
                            Navigator.pop(context, false);
                          }),
                        ),
                      ),
                    ),
                    //Botão de confirmar
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          iconSize: 90,
                          splashRadius: 45,
                          onPressed: (() {
                            //validar dados
                            //se os dados forem válidos, salvar no banco
                            Navigator.pop(context, true);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
