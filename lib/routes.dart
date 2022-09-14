import 'package:flutter/cupertino.dart';
import 'package:prototipo_navegacao/gerenciar_professores.dart';
import 'package:prototipo_navegacao/menu_principal.dart';

import 'login.dart';

class Routes {
  static const String login = '/login';
  static const String homePage = '/homePage';
  static const String professores = '/professores';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginView(),
      homePage: (context) => const MenuPrincipalView(),
      professores: (context) => const ProfessoresView(),
    };
  }
}
