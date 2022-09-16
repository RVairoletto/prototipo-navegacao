import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import 'widgets/default_user_drawer.dart';

class ProfessoresView extends StatefulWidget {
  const ProfessoresView({super.key});

  @override
  State<ProfessoresView> createState() => _ProfessoresViewState();
}

class _ProfessoresViewState extends State<ProfessoresView> {
  //lista temporária de profs
  final TextEditingController _ctrTxfPesquisa = TextEditingController();
  final items = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DefaultUserDrawer(),
        appBar: AppBar(
          title: const Text("Gerenciar Professores"),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //Coluna com a parte de pesquisa e a listagem
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                //Linha com a caixa de pesquisa e o botão de pesquisa
                Row(
                  children: [
                    //Caixa de pesquisa
                    Flexible(
                      child: TextFormField(
                        controller: _ctrTxfPesquisa,
                        decoration: InputDecoration(
                            suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Botão de adicionar
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  items.add(_ctrTxfPesquisa.text);
                                  _ctrTxfPesquisa.clear();
                                });
                              },
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
                //Listgrid com os resultados
                Flexible(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = items[index];

                        return ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          leading: const FlutterLogo(),
                          title: Text(item),
                          trailing: IconButton(
                            //Botão de remover
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                items.remove(item);
                                _ctrTxfPesquisa.clear();
                              });
                            },
                          ),
                        );
                      }),
                ),
                //Linha com os botões de adicionar, alterar e excluir um registro
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Cadastrar
                    IconButton(
                      icon: const Icon(Icons.add),
                      iconSize: 80,
                      padding: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.width / 10)),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.professoresForm);
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
                        Navigator.pushNamed(context, Routes.professoresForm);
                      },
                    ),
                    //Remover
                    IconButton(
                      icon: const Icon(Icons.remove_circle),
                      iconSize: 80,
                      padding: EdgeInsets.symmetric(
                          horizontal: (MediaQuery.of(context).size.width / 10)),
                      onPressed: () async {
                        await Navigator.pushNamed(context, Routes.modal) != null
                          ? print("true") //deletar
                          : print("false"); //cancelar o delete
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
