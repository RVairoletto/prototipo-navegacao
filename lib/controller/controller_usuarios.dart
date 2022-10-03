import 'package:flutter/material.dart';
import 'package:prototipo_navegacao/model/usuario.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../util/routes.dart';
import '../widgets/default_alert_dialog.dart';

class ControllerUsuarios {
  //Declaração de variáveis
  String error = '';

  //Adicionar usuário
  Future<UsuarioModel?> postUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'signup',
      token: '',
      data: usuario.toJson(),
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }
    return null;
  }

  //Alterar usuário
  Future<UsuarioModel?> putUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().put(
      endPoint: '', //endpoint pendente
      token: '',
      data: usuario.toJson(),
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }

    return null;
  }

  //Get múltiplos usuários
  Future<List<UsuarioModel>?> getUsuario(
      BuildContext context, Map? filters) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'users',
      token: '',
      filters: filters,
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      List<UsuarioModel> usuarios = [];

      for (int i = 0; i < response.body; i++) {
        final item = response.body[i];

        usuarios.add(UsuarioModel.fromJson(item));
      }

      return usuarios;
    }

    return null;
  }

  //Get usuário

  //Excluir usuário
  Future<UsuarioModel?> deleteUsuario(
      BuildContext context, UsuarioModel usuario) async {
    ApiResponse response = await ApiClient().delete(
      endPoint: '', //endpoint pendente
      token: '',
    );

    //confirmar códigos de sucesso e erro
    if (response.statusCode > 299) {
      response.body['error'].forEach((requestError) {
        error += requestError['msg'] + "\n";
      });
    } else {
      return usuario;
    }

    return null;
  }

  //Gerar datatable
  DataRow gerarDataRow(BuildContext context, UsuarioModel? usuario) {
    return DataRow(cells: [
      DataCell(Text(usuario!.name)),
      DataCell(Text(usuario.email)),
      DataCell(IconButton( //Alterar
        icon: const Icon(Icons.app_registration),
        onPressed: () {
          Navigator.pushNamed(context, Routes.usuariosForm);
        },
      )),
      DataCell(IconButton( //Excuir
        icon: const Icon(Icons.remove_circle),
        onPressed: () async {
          final confirmarExclusao = await showDialog(
            context: context,
            builder: (context) {
              return const DefaultAlertDialog();
            },
          );

          if (confirmarExclusao) {
            deleteUsuario(context, usuario);
          }
        },
      )),
    ]);
  }
}
