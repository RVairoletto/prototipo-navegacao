import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_usuarios.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_checkbox.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

import '../../model/usuario.dart';

class UsuariosView extends StatefulWidget {
  const UsuariosView({super.key});

  @override
  State<UsuariosView> createState() => _UsuariosViewState();
}

//View de gerenciar usuários
class _UsuariosViewState extends State<UsuariosView> {
  ControllerUsuarios ctrUsuarios = ControllerUsuarios();
  List<UsuarioModel> usuarios = [];

  TextEditingController ctrNome = TextEditingController();
  TextEditingController ctrEmail = TextEditingController();

  bool isListagemAtivos = true;

  //Função para gerar as linhas do datagrid de forma dinâmica
  DataRow _gerarDataRow(BuildContext context, UsuarioModel usuario) {
    return DataRow(
      cells: [
        //Nome
        DataCell(
          Text(usuario.name)
        ),
        //Email
        DataCell(
          Text(usuario.email)
        ),
        //Status
        DataCell(usuario.disabled
          ? const Text('Desabilitado')
          : const Text('Ativo')
        ),
        //Alterar
        DataCell(
          IconButton(
            icon: const Icon(Icons.app_registration),
            onPressed: () {
              //Restrição para bloquear alteração do usuário admin
              if (usuario.email != 'admin@email.com') {
                Navigator.pushNamed(context, Routes.usuariosForm,arguments: usuario.id).then((value) {
                  fetchUsuarios();
                });
              }
            },
          )
        ),
        //Excluir
        DataCell(
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () async {
              //Restrição para bloquear exclusão do usuário admin
              if (usuario.email != 'admin@email.com') {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const DefaultAlertDialog();
                  },
                ).then((value) async {
                  if (value == true) {
                    await ctrUsuarios.disableUsuario(usuario).then((value) {
                      showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: value
                              ? const Text('Sucesso')
                              : const Text('Aviso'),
                            content: value
                              ? const Text('O usuário foi desabilitado com sucesso')
                              : const Text('Não foi possível desabilitar o usuário'),
                            actions: [
                              TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                  fetchUsuarios();
                                }),
                                child: const Text('Ok')
                              )
                            ],
                          );
                        })
                      );
                    });
                  }
                });
              }
            },
          )
        ),
      ]
    );
  }

  //Função para buscar usuários
  fetchUsuarios() async {
    usuarios = await ctrUsuarios.getUsuarios();

    setState(() {
      //
    });
  }

  @override
  void initState() {
    fetchUsuarios();
    super.initState();
  }

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
                  //Textfield de nome
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: ctrNome,
                        autofocus: true,
                        decoration: const InputDecoration(
                          label: Text('Nome'),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4
                          )
                        ),
                      ),
                    ),
                  ),
                  //Textfield de email
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: ctrEmail,
                        decoration: const InputDecoration(
                          label: Text('E-mail'),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 4
                          )
                        ),
                      ),
                    ),
                  ),
                  //Checkbox de listagem de usuários ativos
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: LabeledCheckbox(
                        label: 'Listar apenas usuários ativos',
                        padding: const EdgeInsets.all(8),
                        value: isListagemAtivos,
                        onChanged: (value) {
                          setState(() {
                            isListagemAtivos = value;
                          });
                        },
                      )
                    ),
                  ),
                  //Botão pesquisar
                  //todo implementar filtro por nome
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        fetchUsuarios();
                      },
                      child: const Text('Pesquisar'),
                    ),
                  ),
                ],
              ),
              //Datatable
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.65,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    children: [
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
                          //Status
                          DataColumn(
                            label: Expanded(
                              child: Text('Status'),
                            ),
                          ),
                          //Botão de alterar
                          DataColumn(
                            label: Flexible(
                              child: Text('Alterar'),
                            ),
                          ),
                          //Botão de Desabilitar
                          DataColumn(
                            label: Flexible(
                              child: Text('Desabilitar'),
                            ),
                          ),
                        ],
                        rows: [
                          //grid gerado dinamicamente no controller de usuario
                          //baseado nos resultados da query de pesquisa
                          for (int i = 0; i < usuarios.length; i++)
                            if (!usuarios[i].disabled || !isListagemAtivos)
                              _gerarDataRow(context, usuarios[i])
                            // else if(!isListagemAtivos)
                            //   _gerarDataRow(context, usuarios[i])
                        ],
                      ),
                    ]
                  )
                ),
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
                      horizontal: (MediaQuery.of(context).size.width / 10)
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.usuariosForm).then((value) {
                        fetchUsuarios();
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
