import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';

class NiveisAcessoFormView extends StatefulWidget {
  final int? id;
  const NiveisAcessoFormView({super.key, this.id});

  @override
  State<NiveisAcessoFormView> createState() => _NiveisAcessoFormViewState();
}

class _NiveisAcessoFormViewState extends State<NiveisAcessoFormView> {
  TextEditingController ctrDescricao = TextEditingController();

  ControllerNiveisAcesso ctrNiveisAcesso = ControllerNiveisAcesso();

  NivelAcessoModel nivel = NivelAcessoModel();

  dynamic args;
  bool isAlteracao = false;

  fetchNivelAcesso() async {
    nivel = await ctrNiveisAcesso.getNivelAcessoById(widget.id!);

    ctrDescricao.text = nivel.description;

    setState(() {
      //
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = widget.id;

    //Alteracao de usuario
    if (args.runtimeType == int) {
      isAlteracao = true;
      fetchNivelAcesso();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Material(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Textbox de descrição
                  TextFormField(
                    autofocus: true,
                    controller: ctrDescricao,
                    decoration: const InputDecoration(label: Text('Descrição')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Botão de cancelar
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            return;
                          },
                          child: const Text('Cancelar')),
                      //Botão de confirmar
                      ElevatedButton(
                        onPressed: () async {
                          final String? respNivel;
                          String titulo;
                          String conteudo;

                          if(isAlteracao){
                            nivel.description = ctrDescricao.text;
                            
                            respNivel = await ctrNiveisAcesso.editNivelAcesso(nivel);
                          } else {
                            respNivel = await ctrNiveisAcesso.postNivelAcesso(ctrDescricao.text);
                          }

                          if (respNivel == null) {
                            //sucesso
                            titulo = 'Sucesso';
                            conteudo = isAlteracao
                            ? 'Nível de acesso alterado com sucesso'
                            : 'Nível de acesso salvo com sucesso';
                          } else {
                            titulo = 'Aviso';
                            conteudo = 'A operação não pôde ser realizada';
                          }

                          await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(titulo),
                                content: Text(conteudo),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'))
                                ],
                              );
                            }
                          ).then((value) {
                            if(respNivel == null){
                              Navigator.pop(context);
                            }
                          });
                        },
                        child: const Text('Confirmar')
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
