import 'package:flutter/cupertino.dart';
import 'package:prototipo_navegacao/menu_principal.dart';

import 'login.dart';

class Routes {
  static const String login = '/login';
  static const String homePage = '/homePage';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginView(),
      homePage: (context) => const MenuPrincipalView(),
    };
  }
}
