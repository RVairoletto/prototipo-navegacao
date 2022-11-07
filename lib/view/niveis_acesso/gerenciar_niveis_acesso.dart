import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';
import 'package:prototipo_navegacao/view/niveis_acesso/niveis_acesso_form.dart';
import 'package:prototipo_navegacao/widgets/default_alert_dialog.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class NiveisAcessoView extends StatefulWidget {
  const NiveisAcessoView({super.key});

  @override
  State<NiveisAcessoView> createState() => _NiveisAcessoViewState();
}

class _NiveisAcessoViewState extends State<NiveisAcessoView> {
  List<NivelAcessoModel> niveisAcesso = [];

  ControllerNiveisAcesso ctrNiveisAcesso = ControllerNiveisAcesso();

  DataRow _gerarDataRow(BuildContext context, NivelAcessoModel nivelAcesso) {
    return DataRow(cells: [
      //Descrição
      DataCell(
        Text(nivelAcesso.description)
      ),
      //Alterar
      DataCell(
        IconButton(
          icon: const Icon(Icons.app_registration),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return NiveisAcessoFormView(id: nivelAcesso.id);
              }
            ).then((value) => {
              fetchNiveisAcesso()
            });
          },
        )
      ),
      //Excluir
      DataCell(
        IconButton(
          icon: const Icon(Icons.remove_circle),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return const DefaultAlertDialog();
              },
            ).then((value) async {
              if(value == true) {
                await ctrNiveisAcesso.deleteNivelAcesso(nivelAcesso).then((value) {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        title: value == null ? const Text('Sucesso') : const Text('Aviso'),
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
          },
        )
      ),
    ]);
  }

  fetchNiveisAcesso() async {
    niveisAcesso = await ctrNiveisAcesso.getNiveisAcesso();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Níveis de Acesso'),
      ),
      drawer: const DefaultUserDrawer(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const NiveisAcessoFormView();
                        }
                      ).then((value) => {
                        fetchNiveisAcesso()
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
