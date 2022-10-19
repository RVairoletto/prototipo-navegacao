import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

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

  ControllerUsuarios controllerUsuario = ControllerUsuarios();

  bool exibirSenha = false;
  bool exibirConfirmarSenha = false;
  bool isAlteracao = false;

  dynamic args;

  UsuarioModel usuario = UsuarioModel();

  fetchUsuario() async {
    UsuarioModel user = await controllerUsuario.getUsuarioById(args);
    ctrNomeUsuario.text = user.name;
    ctrEmail.text = user.email;
    
    setState(() {
      //
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments;

    //Alteracao de usuario
    if (args.runtimeType == int) {
      isAlteracao = true;
      fetchUsuario();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Usuário"),
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
                              readOnly: isAlteracao,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: ctrEmail,
                              decoration:
                                  const InputDecoration(label: Text("E-mail")),
                              validator: (value) {
                                String email = value ?? '';

                                if (!EmailValidator.validate(email)) {
                                  return 'Insira um e-mail válido\n';
                                }

                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Linha com os campos de senha e confirmar senha
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Campo de senha
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ctrSenha,
                              obscureText: !exibirSenha,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) => setState(() {
                                //feito para o validator do campo de confirmar senha atualizar
                                //caso esse campo se torne igual ao de confirmar senha
                              }),
                              decoration: InputDecoration(
                                labelText: 'Senha',
                                border: InputBorder.none,
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
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return 'Esse campo é obrigatório';
                                }

                                String msgErro =
                                    controllerUsuario.validarSenha(value);

                                if (msgErro.isNotEmpty) {
                                  return msgErro;
                                }

                                return null;
                              }),
                            ),
                          ),
                        ),
                        //Campo de confirmar senha
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.always,
                              controller: ctrConfirmarSenha,
                              obscureText: !exibirConfirmarSenha,
                              validator: (value) {
                                if (value != ctrSenha.text) {
                                  return 'As senhas devem ser iguais';
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Confirmar Senha',
                                border: InputBorder.none,
                                suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => exibirConfirmarSenha =
                                        !exibirConfirmarSenha,
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
                          ),
                        ),
                      ],
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
                          tooltip: 'Cancelar',
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
                          tooltip: 'Salvar',
                          icon: const Icon(Icons.save),
                          iconSize: 90,
                          splashRadius: 45,
                          onPressed: (() async {
                            //Validar dados
                            // String msgErro = controllerUsuario.validarCadastro(
                            //   ctrNomeUsuario.text,
                            //   ctrEmail.text,
                            //   ctrSenha.text,
                            //   ctrConfirmarSenha.text,
                            // );

                            // if (msgErro != '') {
                            //   showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return AlertDialog(
                            //           title: const Text('Aviso'),
                            //           content: Text(msgErro),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: (() =>
                            //                     Navigator.pop(context)),
                            //                 child: const Text('Ok'))
                            //           ],
                            //         );
                            //       });

                            //   return;
                            // }

                            usuario.name = ctrNomeUsuario.text;
                            usuario.email = ctrEmail.text;
                            usuario.password = ctrSenha.text;

                            if(isAlteracao){
                              controllerUsuario.putUsuario(context, usuario);
                            } else {
                              controllerUsuario.postUsuario(context, usuario);
                            }

                            //Salvou com sucesso
                            if (controllerUsuario.error.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: const Text('Sucesso'),
                                      content: const Text(
                                          'Seu cadastro foi registrado'),
                                      actions: [
                                        TextButton(
                                            onPressed: (() =>
                                                Navigator.pop(context)),
                                            child: const Text('Ok'))
                                      ],
                                    );
                                  }));

                              Navigator.pop(context, true);
                            }
                            //Não salvou com sucesso
                            else {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: const Text('Algo deu errado'),
                                      content: Text(
                                          'O usuário não pôde ser salvo\n${controllerUsuario.error}'),
                                      actions: [
                                        TextButton(
                                            onPressed: (() =>
                                                Navigator.pop(context, false)),
                                            child: const Text('Ok'))
                                      ],
                                    );
                                  }));
                            }
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
