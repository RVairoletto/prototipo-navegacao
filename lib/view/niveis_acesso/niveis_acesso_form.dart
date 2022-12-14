import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_menus.dart';
import 'package:prototipo_navegacao/controller/controller_niveis_acesso.dart';
import 'package:prototipo_navegacao/controller/controller_permissions.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';
import 'package:prototipo_navegacao/model/permissions.dart';
import 'package:prototipo_navegacao/widgets/drawer_menu_items.dart';

class NiveisAcessoFormView extends StatefulWidget {
  const NiveisAcessoFormView({super.key});

  @override
  State<NiveisAcessoFormView> createState() => _NiveisAcessoFormViewState();
}

//View de formulário de nível de acesso
class _NiveisAcessoFormViewState extends State<NiveisAcessoFormView> {
  TextEditingController ctrDescricao = TextEditingController();

  ControllerNiveisAcesso ctrNiveisAcesso = ControllerNiveisAcesso();
  ControllerMenus ctrMenus = ControllerMenus();
  ControllerPermissions ctrPermissions = ControllerPermissions();

  NivelAcessoModel nivel = NivelAcessoModel();

  dynamic args;
  bool isAlteracao = false;

  List<DrawerMenuItem> menus = [];

  Map<String, bool> permissions = {};

  //Buscar menus
  fetchMenus() async {
    menus = await ctrMenus.getMenus();

    //Inicializar as permissões como falsas
    for (int i = 0; i < menus.length; i++) {
      permissions[menus[i].description] = false;
    }

    setState(() {
      //
    });
  }

  //Buscar permissões
  fetchPermissions() async {
    List<Permission> listPermissions = await ctrPermissions.getPermissions(args);

    //Marcar as permissões atuais deste nível de acesso como verdadeiras
    for(int i = 0; i < menus.length; i++){
      for(int x = 0; x < listPermissions.length; x++){
        if(menus[i].description == listPermissions[x].description){
          permissions[menus[i].description] = true;

          break;
        }
      }
    }

    setState(() {
      //
    });
  }

  //Buscar o nível de acesso caso seja alteração
  fetchNivelAcesso() async {
    nivel = await ctrNiveisAcesso.getNivelAcessoById(args);

    ctrDescricao.text = nivel.description;

    setState(() {
      //
    });
  }

  @override
  void initState() {
    fetchMenus();
    super.initState();
  }

  @override
  //Função chamada automaticamente após o init}State
  void didChangeDependencies() {
    args = ModalRoute.of(context)!.settings.arguments;

    //Caso seja alteração
    if (args != null && args.runtimeType == int) {
      isAlteracao = true;
      fetchNivelAcesso();
      fetchPermissions();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nível de Acesso')
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8),
          //Coluna com tudo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Textfield de descrição
              TextFormField(
                autofocus: true,
                controller: ctrDescricao,
                decoration: const InputDecoration(
                  label: Text('Descrição')
                ),
              ),
              //Listagem dos menus
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ListView(
                    children: [
                      //Geração dinâmica das linhas do grid
                      for (int i = 0; i < menus.length; i++)
                        //Componente de lista com checkbox
                        CheckboxListTile(
                          title: menus[i].text,
                          value: permissions[menus[i].description],
                          onChanged: (value) {
                            permissions[menus[i].description] = value!;

                            setState(() {
                              //
                            });
                          },
                        )
                      ],
                    )
                  ),
                ),
              ),
              //Linha com os botões de cancelar e confirmar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Botão de cancelar
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      return;
                    },
                    child: const Text('Cancelar')
                  ),
                  //Botão de confirmar
                  ElevatedButton(
                    onPressed: () async {
                      final Map<String, dynamic> respNivel;
                      String titulo;
                      String conteudo;

                      if (isAlteracao) {
                        nivel.description = ctrDescricao.text;

                        respNivel = await ctrNiveisAcesso.editNivelAcesso(nivel);
                      } else {
                        respNivel = await ctrNiveisAcesso.postNivelAcesso(ctrDescricao.text);
                      }
                      
                      //sucesso
                      if (!respNivel.containsKey('error')) {
                        
                        titulo = 'Sucesso';
                        conteudo = isAlteracao
                          ? 'Nível de acesso alterado com sucesso'
                          : 'Nível de acesso salvo com sucesso';

                        final NivelAcessoModel nivelAcesso = respNivel['nivelAcesso'];

                        //Limpar permissões pra evitar dados duplicados
                        await ctrPermissions.deletePermissions(nivelAcesso.id);

                        for (int i = 0; i < menus.length; i++) {
                          if (permissions[menus[i].description] == true) {
                            await ctrPermissions.postPermission(nivelAcesso.id, menus[i].id);
                          }
                        }
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
                                child: const Text('Ok')
                              )
                            ],
                          );
                      }).then((value) {
                        if (!respNivel.containsKey('error')) {
                          Navigator.pop(context, true);
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
    );
  }
}
