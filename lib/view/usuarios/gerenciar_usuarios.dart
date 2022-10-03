import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

import '../../model/usuario.dart';

class UsuariosView extends StatefulWidget {
  const UsuariosView({super.key});

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

class _UsuariosViewState extends State<UsuariosView> {
  ControllerUsuarios ctrUsuarios = ControllerUsuarios();
  List<UsuarioModel>? usuarios;

  TextEditingController ctrNome = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gerenciar Usuários"),
        ),
        drawer: const DefaultUserDrawer(),
        body: SizedBox(
            //Coluna com tudo
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Linha com as caixas de pesquisa por nome e email e o botão de pesquisar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //TextBox de nome
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: ctrNome,
                        autofocus: true,
                        decoration: const InputDecoration(
                            label: Text('Nome'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 4)),
                      ),
                    ),
                  ),
                  //TextBox de email
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: ctrEmail,
                        decoration: const InputDecoration(
                            label: Text('E-mail'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 4)),
                      ),
                    ),
                  ),
                  //Botão pesquisar
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          usuarios = ctrUsuarios.getUsuario(context, null) as List<UsuarioModel>?;
                        });
                      },
                      child: const Text('Pesquisar'),
                    ),
                  ),
                ],
              ),
              //Datatable
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListView(children: [
                      DataTable(
                        //Colunas
                        columns: const [
                          //Nome
                          DataColumn(
                            label: Expanded(
                              child: Text('Nome'),
                            ),
                          ),
                          //E-mail
                          DataColumn(
                            label: Expanded(
                              child: Text('E-mail'),
                            ),
                          ),
                          //Botão de alterar
                          DataColumn(
                            label: Flexible(
                              child: Text(''),
                            ),
                          ),
                          //Botão de Excluir
                          DataColumn(
                            label: Flexible(
                              child: Text(''),
                            ),
                          ),
                        ],
                        rows: [
                          //grid gerado dinamicamente no controller de usuario
                          //baseado nos resultados da query de pesquisa
                          for (int i = 0; i < usuarios!.length; i++)
                            ctrUsuarios.gerarDataRow(context, usuarios![i])
                        ],
                      ),
                    ])),
              ),
              //Linha com os botões de adicionar, alterar e remover
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Adicionar
                  IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 10)),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.usuariosForm);
                    },
                  ),
                  //Alterar
                  IconButton(
                    icon: const Icon(Icons
                        .app_registration), //todo arranjar ícone melhor pra esse botão
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 10)),
                    onPressed: () {
                      //todo implementar seleção de item para poder alterar
                      Navigator.pushNamed(context, Routes.usuariosForm);
                    },
                  ),
                  //Remover
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                        horizontal: (MediaQuery.of(context).size.width / 10)),
                    onPressed: () async {
                      //todo implementar seleção de item para poder remover
                      final confirmarExclusao = await showDialog(
                        context: context,
                        builder: (context) {
                          return const DefaultAlertDialog();
                        },
                      );

                      if (confirmarExclusao == true) {
                        //realizar exclusão e dar setState
                      }
                    },
                  )
                ],
              )
            ],
          ),
        )));
  }
}
