import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/permissions.dart';

//Classe de controller responsável pelas operações de permissões
class ControllerPermissions {
  //Post permissão
  Future<String?> postPermission(int? levelId, int? menuId) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'permission',
      data: {
        'levelid': levelId,
        'menuid': menuId,
      }
    );

    if(response.statusCode != 204) {
      return response.body['error'] ?? 'Não foi possível cadastrar a permissão';
    }

    return null;
  }

  //Get permissões por levelId
  //Essa função retorna todas as permissões vinculadas a um determinado nível de acesso
  Future<List<Permission>> getPermissions(int? levelId) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'permission/$levelId',
    );

    if(response.statusCode != 200) {
      throw Exception(response.body['error'] ?? 'Não foi possível buscar as permissões');
    }

    return response.body.map<Permission>((permission) => Permission.fromJson(permission)).toList();
  }

  //Excluir permissões
  Future<String?> deletePermissions(int? levelId) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'permission/delete',
      data: {
        'levelid': levelId
      }
    );

    if(response.statusCode != 204) {
      return (response.body['error'] ?? 'Não foi possível excluir as permissões');
    }

    return null;
  }
}
