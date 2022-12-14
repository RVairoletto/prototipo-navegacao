import 'package:flutter/material.dart';

class ProfessoresFormView extends StatefulWidget {
  const ProfessoresFormView({super.key});

  @override
  State<ProfessoresFormView> createState() => _ProfessoresFormViewState();
}

//View de formulário de professores
class _ProfessoresFormViewState extends State<ProfessoresFormView> {
  final TextEditingController ctrNome = TextEditingController();
  final TextEditingController ctrCodigo = TextEditingController();
  final TextEditingController ctrDisciplina = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de Professor"),
      ),
      body: SizedBox(
        //Coluna com tudo
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Linha com as caixas de texto
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Nome
                  TextFormField(
                    controller: ctrNome,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                      constraints: BoxConstraints(
                        maxHeight: 80,
                        maxWidth: 500,
                      )
                    ),
                  ),
                  //Código
                  TextFormField(
                    controller: ctrCodigo,
                    decoration: const InputDecoration(
                      label: Text("Código"),
                      constraints: BoxConstraints(
                        maxHeight: 80,
                        maxWidth: 220,
                      )
                    ),
                  ),
                  //Disciplina
                  TextFormField(
                    controller: ctrDisciplina,
                    decoration: const InputDecoration(
                      label: Text("Disciplina"),
                      constraints: BoxConstraints(
                        maxHeight: 80,
                        maxWidth: 340,
                      )
                    ),
                  ),
                ],
              ),
            ),
            //Linha no rodapé com os botões de salvar ou cancelar
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Salvar
                  IconButton(
                    icon: const Icon(Icons.add),
                    iconSize: 90,
                    splashRadius: 45,
                    onPressed: () {
                      //salvar dados
                      Navigator.pop(context);
                    },
                  ),
                  //Cancelar
                  IconButton(
                    icon: const Icon(Icons.cancel),
                    iconSize: 90,
                    splashRadius: 45,
                    onPressed: () {
                      //cancelar o cadastro e retornar pra tela anterior
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
