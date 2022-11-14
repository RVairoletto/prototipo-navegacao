import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/model/usuario_atual.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/routes.dart';
import '../widgets/default_user_drawer.dart';

class AlterarSenhaView extends StatefulWidget {
  const AlterarSenhaView({super.key});

  @override
  State<AlterarSenhaView> createState() => _AlterarSenhaViewState();
}

class _AlterarSenhaViewState extends State<AlterarSenhaView> {
  ControllerUsuarios controllerUsuario = ControllerUsuarios();
  TextEditingController ctrSenhaAtual = TextEditingController();
  TextEditingController ctrNovaSenha = TextEditingController();
  TextEditingController ctrConfirmarSenha = TextEditingController();

  bool exibirSenhaAtual = false;
  bool exibirNovaSenha = false;
  bool exibirConfirmarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alterar Senha'),
      ),
      drawer: const DefaultUserDrawer(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              //Textbox com o campo de senha atual
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ctrSenhaAtual,
                    obscureText: !exibirSenhaAtual,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Senha atual',
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => exibirSenhaAtual = !exibirSenhaAtual,
                        ),
                        child: Icon(
                          exibirSenhaAtual
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

                      return null;
                    }),
                  ),
                ),
              ),
              //Textbox com o campo de nova senha
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: ctrNovaSenha,
                    obscureText: !exibirNovaSenha,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => setState(() {
                      //feito para o validator do campo de confirmar senha atualizar
                      //caso esse campo se torne igual ao de confirmar senha
                    }),
                    decoration: InputDecoration(
                      labelText: 'Nova senha',
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => exibirNovaSenha = !exibirNovaSenha,
                        ),
                        child: Icon(
                          exibirNovaSenha
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

                      String msgErro = controllerUsuario.validarSenha(value);

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
                      if (value != ctrNovaSenha.text) {
                        return 'As senhas devem ser iguais';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => exibirConfirmarSenha =
                              !exibirConfirmarSenha,
                        ),
                        child: Icon(
                          exibirConfirmarSenha
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF757575),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Linha com os botões de confirmar e cancelar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Botão de confirmar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        UsuarioAtualModel usuarioAtual = UsuarioAtualModel.fromJson(
                          jsonDecode(prefs.getString('usuario_atual') ?? '')
                        );
                        
                        //Validar se o usuario foi corretamente recuperado
                        if(usuarioAtual.toString() == ''){
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text('Aviso'),
                                content: const Text('Não foi possível conferir seu cadastro'),
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

                          return;
                        }

                        //Validar senha atual
                        
                        //Validar se a senha está dentro dos padrões
                        String msgErro = controllerUsuario.validarSenha(ctrNovaSenha.text);

                        if (msgErro.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Aviso'),
                                content: Text(msgErro),
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

                          return;
                        }

                        //Alterar senha
                        await controllerUsuario.alterarSenha(usuarioAtual, ctrNovaSenha.text);

                        //Caso a senha tenha sido alterada com sucesso
                        if(controllerUsuario.error == ''){
                          //mensagem de sucesso
                          await showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text('Sucesso'),
                                content: const Text('Sua senha foi alterada com sucesso'),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'))
                                ],
                              );
                            }
                          ).then((value) {
                            Navigator.pushNamed(context, Routes.homePage);
                          });
                        } 
                        else {
                          showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: const Text('Algo deu errado'),
                                content: Text(controllerUsuario.error),
                                actions: [
                                  TextButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'))
                                ],
                              );
                            }
                          );
                        }
                      },
                      child: const Text('Confirmar')
                    ),
                  ),
                  //Botão de cancelar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.homePage);
                      },
                      child: const Text('Cancelar')
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
