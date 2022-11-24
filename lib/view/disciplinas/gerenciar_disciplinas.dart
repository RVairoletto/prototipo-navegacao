import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';

class DisciplinasView extends StatefulWidget {
  const DisciplinasView({super.key});

  @override
  State<DisciplinasView> createState() => _DisciplinasViewState();
}

//View de gerenciar discipinas
//Componentes pendentes
class _DisciplinasViewState extends State<DisciplinasView> {
  final TextEditingController ctrPesquisa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Disciplinas"),
      ),
      drawer: const DefaultUserDrawer(),
      body: SizedBox(
        //Coluna principal
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Linha com os botões de pesquisar e adicionar
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Caixa de pesquisa
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: TextFormField(
                      controller: ctrPesquisa,
                      decoration: InputDecoration(
                        //Botão de pesquisa
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            //pesquisar disciplinas cadastradas e listar no grid
                          },
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
            //Grid com as disciplinas
            //todo widget de grid
            //Se basear no grid de gerenciar usuários
          ],         
        )
      )
    );
  }
}
