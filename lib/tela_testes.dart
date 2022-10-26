import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/controller/controller_login.dart';
import 'package:prototipo_navegacao/widgets/default_user_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestesView extends StatefulWidget {
  const TestesView({super.key});

  @override
  State<TestesView> createState() => _TestesViewState();
}

class _TestesViewState extends State<TestesView> {
  List<String> descNiveisAcesso = [];
  String dropdownValue = '';

  fetchNiveis(){
    descNiveisAcesso = ['Nivel 1', 'Nivel 2', 'Nivel 3'];
    dropdownValue = descNiveisAcesso.first;
  }

  @override
  void initState() {
    fetchNiveis();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ControllerLogin ctrLogin = ControllerLogin();

    return Scaffold(
        drawer: const DefaultUserDrawer(),
        appBar: AppBar(title: const Text("Tela de testes")),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //forgotPass
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: (){
                      ctrLogin.forgotPassword('renan.net2014@gmail.com');
                    },
                    child: const Text('Esqueci minha senha'),
                  )
                )
              ),
              //combobox
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (value) {
                      dropdownValue = value!;

                      setState(() {
                        //  
                      });
                    },
                    items: [
                      for(int i = 0; i < descNiveisAcesso.length; i++)
                        DropdownMenuItem(
                          value: descNiveisAcesso[i],
                          child: Text(descNiveisAcesso[i])
                        )
                    ]
                  )
                )
              ),
              //testando shared preferences
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Teste de shared preferences'),
                            content: Text(
                                prefs.getString('teste') ?? 'não deu certo'),
                          );
                        });
                  },
                  child: const Text('Testar shared preferences')),
            ],
          ),
        ));
  }
}
