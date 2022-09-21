import 'package:flutter/cupertino.dart';
import 'package:prototipo_navegacao/tela_testes.dart';
import 'package:prototipo_navegacao/view/professores/gerenciar_professores.dart';
import 'package:prototipo_navegacao/view/menu_principal.dart';
import 'package:prototipo_navegacao/view/professores/professores_form.dart';

import '../view/login.dart';

class Routes {
  static const String login = '/login';
  static const String homePage = '/homePage';
  static const String professores = '/professores';
  static const String professoresForm = '/professoresForm';
  static const String modal = '/modal';
  static const String telaTestes = '/telaTestes';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginView(),
      homePage: (context) => const MenuPrincipalView(),
      professores: (context) => const ProfessoresView(),
      professoresForm: (context) => const ProfessoresFormView(),
      telaTestes: (context) => const TestesView(),
    };
  }
}
