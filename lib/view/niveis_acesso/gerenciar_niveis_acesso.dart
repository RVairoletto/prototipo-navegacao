import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'package:prototipo_navegacao/view/niveis_acesso/niveis_acesso_form.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class NiveisAcessoView extends StatefulWidget {
  const NiveisAcessoView({super.key});

  @override
  State<NiveisAcessoView> createState() => _NiveisAcessoViewState();
}

//View de listagem de níveis de acesso
class _NiveisAcessoViewState extends State<NiveisAcessoView> {
  List<NivelAcessoModel> niveisAcesso = [];

  ControllerNiveisAcesso ctrNiveisAcesso = ControllerNiveisAcesso();

  //Função para gerar cada linha do datagrid
  //Em tempo de execução
  DataRow _gerarDataRow(BuildContext context, NivelAcessoModel nivelAcesso) {
    return DataRow(
      cells: [
        //Descrição
        DataCell(
          Text(nivelAcesso.description)
        ),
        //Alterar
        DataCell(
          IconButton(
            icon: const Icon(Icons.app_registration),
            onPressed: () {
              //Restrição para bloquear alterações no nível de acesso admin
              if (nivelAcesso.description != 'admin') {
                Navigator.pushNamed(context, Routes.niveisAcessoForm, arguments: nivelAcesso.id).then((value) => {
                  fetchNiveisAcesso()
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
              //Restrição para bloquear a exclusão do nível de acesso admin
              if (nivelAcesso.description != 'admin') {
                //Modal de confirmação de exclusão padrão
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const DefaultAlertDialog();
                  },
                ).then((value) async {
                  //Se o usuário tiver confirmado a exclusão
                  if(value == true) {
                    await ctrNiveisAcesso.deleteNivelAcesso(nivelAcesso).then((value) async {
                      //O conteúdo da janela varia de acordo com a resposta da chamada da API
                      await showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialog(
                            title: value == null
                              ? const Text('Sucesso')
                              : const Text('Aviso'),
                            content: value == null
                              ? const Text('O nível de acesso foi excluído com sucesso')
                              : Text(value),
                            actions: [
                              TextButton(
                                onPressed: (() {
                                  Navigator.pop(context);
                                  fetchNiveisAcesso();
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

  //Buscar níveis de acesso
  fetchNiveisAcesso() async {
    niveisAcesso = await ctrNiveisAcesso.getNiveisAcesso();

    setState(() {
      //
    });
  }

  @override
  //Buscar níveis de acesso ao abrir a janela
  void initState() {
    fetchNiveisAcesso();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Níveis de Acesso'),
      ),
      drawer: const DefaultUserDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        //Coluna com tudo
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Datagrid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DataTable(
                    columns: const [
                      //Nome
                      DataColumn(label: Text('Nome')),
                      //Alterar
                      DataColumn(label: Text('Alterar')),
                      //Excluir
                      DataColumn(label: Text('Excluir')),
                    ],
                    rows: [
                      //grid gerado dinamicamente no controller de niveis de acesso
                      //baseado nos resultados da query de pesquisa
                      for (int i = 0; i < niveisAcesso.length; i++)
                        _gerarDataRow(context, niveisAcesso[i])
                    ],
                  ),
                ),
              ),
              //Linha com o botão de adicionar
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Botão de adicionar
                    IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 80,
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.niveisAcessoForm).then((value) => {
                          if(value == true){
                            fetchNiveisAcesso()
                          }
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
