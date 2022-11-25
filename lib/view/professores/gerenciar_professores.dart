import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/util/routes.dart';
import '../../widgets/default_alert_dialog.dart';
import '../../widgets/default_user_drawer.dart';

class ProfessoresView extends StatefulWidget {
  const ProfessoresView({super.key});

  @override
  State<ProfessoresView> createState() => _ProfessoresViewState();
}

//View de gerenciar professores
class _ProfessoresViewState extends State<ProfessoresView> {
  //lista temporária de profs
  final TextEditingController ctrPesquisa = TextEditingController();

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
                      controller: ctrPesquisa,
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
                                  //
                                });
                              },
                            ),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
              //Listgrid com os resultados
              //todo listgrid
              //Linha com os botões de adicionar, alterar e excluir um registro
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Cadastrar
                  IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width / 10)
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.professoresForm);
                    },
                  ),
                  //Alterar
                  IconButton(
                    icon: const Icon(Icons.app_registration),
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width / 10)
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.professoresForm); //todo passar id para indicar alteração
                    },
                  ),
                  //Remover
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    iconSize: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: (MediaQuery.of(context).size.width / 10)
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return const DefaultAlertDialog();
                        },
                      ).then((value) => {
                        if(value == true){
                          //efetuar exclusão
                        }
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
