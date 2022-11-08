import 'dart:convert';

import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/permissions.dart';

class ControllerPermissions {
  //Post permissão
  Future<String?> postPermission(int? levelId, int? menuId) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'permission',
      data: {
        'levelId': levelId,
        'menuId': menuId,
      }
    );

    if(response.statusCode != 204) {
      return response.body['error'] ?? 'Não foi possível cadastrar a permissão';
    }

    return null;
  }

  //Post permissão
  Future<List<Permission>> getPermissions(int? levelId) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'permission',
      filters: {
        'levelId': levelId
      }
    );

    if(response.statusCode != 204) {
      return response.body['error'] ?? 'Não foi possível buscar as permissões';
    }

    return response.body.map<Permission>((permission) => Permission.fromJson(permission)).toList();
  }

  //Get permissão by id
  Future<Map<String, dynamic>?> getPermissionById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'permission/$id',
    );

    if(response.statusCode != 204) {
      return null;
    }

    return jsonDecode(response.body);
  }
}
