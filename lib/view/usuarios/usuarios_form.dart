import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

class UsuariosFormView extends StatefulWidget {
  const UsuariosFormView({super.key});

  @override
  State<UsuariosFormView> createState() => _UsuariosFormViewState();
}

//View de formulário de usuário
class _UsuariosFormViewState extends State<UsuariosFormView> {
  TextEditingController ctrNomeUsuario = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();
  TextEditingController ctrSenha = TextEditingController();
  TextEditingController ctrConfirmarSenha = TextEditingController();

  ControllerUsuarios ctrUsuario = ControllerUsuarios();
  ControllerNiveisAcesso ctrNiveisAcesso = ControllerNiveisAcesso();

  UsuarioModel usuario = UsuarioModel();

  bool exibirSenha = false;
  bool exibirConfirmarSenha = false;
  bool isAlteracao = false;

  List<NivelAcessoModel> niveisAcesso = [];
  List<dynamic> niveisAcessoUser = [];

  Map<String, dynamic> mapNiveis = {};

  dynamic args;

  //Buscar usuário a ser alterado
  fetchUsuario() async {
    usuario = await ctrUsuario.getUsuarioById(args);
    niveisAcessoUser = await ctrUsuario.getNiveisAcesso(args);

    ctrNomeUsuario.text = usuario.name;
    ctrEmail.text = usuario.email;

    //Marcar níveis de acesso
    for (int i = 0; i < niveisAcesso.length; i++) {
      for (int x = 0; x < niveisAcessoUser.length; x++) {
        if (niveisAcesso[i].id == niveisAcessoUser[x]['id']) {
          mapNiveis[niveisAcesso[i].description] = true;

          break;
        }
      }
    }

    setState(() {
      //
    });
  }

  //Buscar níveis de acesso do usuário
  fetchNiveisAcesso() async {
    niveisAcesso = await ctrNiveisAcesso.getNiveisAcesso();

    //Inicializar níveis de acesso como false
    for (int i = 0; i < niveisAcesso.length; i++) {
      mapNiveis[niveisAcesso[i].description] = false;
    }

    setState(() {
      //
    });
  }

  @override
  void initState() {
    fetchNiveisAcesso();
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
                  //Linha com os campos de nome, email e níveis de acesso
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Campo de nome de usuário
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            autofocus: true,
                            controller: ctrNomeUsuario,
                            decoration: const InputDecoration(
                              label: Text("Nome de Usuário")
                            ),
                          ),
                        ),
                      ),
                      //Campo de email
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            readOnly: isAlteracao,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: ctrEmail,
                            decoration: const InputDecoration(
                              label: Text("E-mail")
                            ),
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
                            readOnly: isAlteracao,
                            controller: ctrSenha,
                            obscureText: !exibirSenha,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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

                              String msgErro = ctrUsuario.validarSenha(value);

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
                            readOnly: isAlteracao,
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
                                  () => exibirConfirmarSenha = !exibirConfirmarSenha
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
                  //Listagem de níveis de acesso
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListView(
                        children: [
                          for (int i = 0; i < niveisAcesso.length; i++)
                            CheckboxListTile(
                              title: Text(niveisAcesso[i].description),
                              value: mapNiveis[niveisAcesso[i].description],
                              onChanged: (value) {
                                mapNiveis[niveisAcesso[i].description] = value!;

                                setState(() {
                                  //
                                });
                              },
                            )
                        ],
                      ),
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
                          //Validar dados de cadastro
                          usuario.name = ctrNomeUsuario.text;
                          usuario.email = ctrEmail.text;
                          usuario.password = ctrSenha.text;

                          if (isAlteracao) {
                            if (ctrNomeUsuario.text.isEmpty) {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Aviso'),
                                    content: const Text('Insira um nome'),
                                    actions: [
                                      TextButton(
                                        onPressed: (() => Navigator.pop(context)),
                                        child: const Text('Ok')
                                      )
                                    ]
                                  );
                                }
                              );

                              return;
                            }
                            //Realizar alteração
                            usuario.id = args;
                            ctrUsuario.editUsuario(usuario);
                          } else {
                            String msgErro = ctrUsuario.validarCadastro(
                              ctrNomeUsuario.text,
                              ctrEmail.text,
                              ctrSenha.text,
                              ctrConfirmarSenha.text,
                            );

                            if (msgErro != '') {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Aviso'),
                                    content: Text(msgErro),
                                    actions: [
                                      TextButton(
                                        onPressed: (() => Navigator.pop(context)),
                                        child: const Text('Ok')
                                      )
                                    ],
                                  );
                                }
                              );

                              return;
                            }

                            //Salvar
                            await ctrUsuario.postUsuario(usuario);
                          }

                          //Vincular níveis de acesso
                          for(int i = 0; i < niveisAcesso.length; i++){
                            for (int x = 0; x < niveisAcessoUser.length; x++) {
                              if(mapNiveis[niveisAcesso[i].description] == true  && niveisAcessoUser[x]['description'] != niveisAcesso[i].description) {
                                await ctrNiveisAcesso.userLevel(usuario.id, niveisAcesso[i].id);
                              }
                              else if(mapNiveis[niveisAcesso[i].description] == false && niveisAcessoUser[x]['description'] == niveisAcesso[i].description) {
                                await ctrNiveisAcesso.deleteUserLevel(usuario.id, niveisAcesso[i].id);
                              }
                            }
                          }

                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: ctrUsuario.error.isEmpty
                                  ? const Text('Sucesso')
                                  : const Text('Aviso'),
                                content: ctrUsuario.error.isEmpty
                                  ? const Text('Operação realizada com sucesso')
                                  : Text(ctrUsuario.error),
                                actions: [
                                  TextButton(
                                    onPressed: (() => Navigator.pop(context)),
                                    child: const Text('Ok')
                                  )
                                ],
                              );
                            }
                          ).then((value) {
                            ctrUsuario.error.isEmpty
                              ? Navigator.pop(context)
                              : null;
                          });
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
