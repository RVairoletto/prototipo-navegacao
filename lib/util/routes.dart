import 'package:flutter/cupertino.dart';
import 'package:prototipo_navegacao/tela_testes.dart';
import 'package:prototipo_navegacao/view/alterar_senha.dart';
import 'package:prototipo_navegacao/view/disciplinas/gerenciar_disciplinas.dart';
import 'package:prototipo_navegacao/view/login/recuperar_senha.dart';
import 'package:prototipo_navegacao/view/niveis_acesso/gerenciar_niveis_acesso.dart';
import 'package:prototipo_navegacao/view/niveis_acesso/niveis_acesso_form.dart';
import 'package:prototipo_navegacao/view/professores/gerenciar_professores.dart';
import 'package:prototipo_navegacao/view/menu_principal.dart';
import 'package:prototipo_navegacao/view/professores/professores_form.dart';
import 'package:prototipo_navegacao/view/usuarios/gerenciar_usuarios.dart';
import 'package:prototipo_navegacao/view/usuarios/usuarios_form.dart';

import '../view/login/login.dart';

class Routes {
  static const String login = '/login';
  static const String homePage = '/homePage';
  static const String professores = '/professores';
  static const String professoresForm = '/professoresForm';
  static const String modal = '/modal';
  static const String telaTestes = '/telaTestes';
  static const String disciplinas = '/disciplinas';
  static const String usuarios = '/usuarios';
  static const String usuariosForm = '/usuariosForm';
  static const String alterarSenha = '/alterarSenha';
  static const String recuperarSenha = '/recuperarSenha';
  static const String niveisAcesso = '/niveisAcesso';
  static const String niveisAcessoForm = '/niveisAcessoForm';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginView(),
      homePage: (context) => const MenuPrincipalView(),
      professores: (context) => const ProfessoresView(),
      professoresForm: (context) => const ProfessoresFormView(),
      telaTestes: (context) => const TestesView(),
      disciplinas: (context) => const DisciplinasView(),
      usuarios: (context) => const UsuariosView(),
      usuariosForm: (context) => const UsuariosFormView(),
      alterarSenha: (context) => const AlterarSenhaView(),
      recuperarSenha: (context) => const RecuperarSenhaView(),
      niveisAcesso: (context) => const NiveisAcessoView(),
      niveisAcessoForm: (context) => const NiveisAcessoFormView(),
    };
  }
}
