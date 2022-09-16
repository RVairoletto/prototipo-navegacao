import 'package:flutter/cupertino.dart';
import 'package:prototipo_navegacao/gerenciar_professores.dart';
import 'package:prototipo_navegacao/menu_principal.dart';
import 'package:prototipo_navegacao/professores_form.dart';

import 'login.dart';
import 'modal.dart';

class Routes {
  static const String login = '/login';
  static const String homePage = '/homePage';
  static const String professores = '/professores';
  static const String professoresForm = '/professoresForm';
  static const String modal = '/modal';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginView(),
      homePage: (context) => const MenuPrincipalView(),
      modal: (context) => const Modal(),
      professores: (context) => const ProfessoresView(),
      professoresForm: (context) => const ProfessoresFormView(),
    };
  }
}
