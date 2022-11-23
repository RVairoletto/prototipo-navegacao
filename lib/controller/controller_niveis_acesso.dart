import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';

//Classe de controller responsável pelas operações de níveis de acesso
class ControllerNiveisAcesso {
  //Post nível de acesso
  Future<Map<String, dynamic>> postNivelAcesso(String description) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel',
      data: {
        'description': description
      }
    );

    if(response.statusCode != 200){
      return {
        'error': response.body['error'] ?? 'Não foi possível cadastrar o nível de acesso'
      };
    }

    //O objeto salvo está sendo retornado como o primeiro item de uma lista
    NivelAcessoModel nivel = NivelAcessoModel.fromJson(response.body[0]);

    //retorno do objeto salvo
    return {
      'nivelAcesso': nivel
    };
  }

  //Get níveis de acesso
  Future<List<NivelAcessoModel>> getNiveisAcesso() async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'accessLevel',
    );

    if(response.statusCode != 200){
      throw Exception(response.body['error'] ?? 'Não foi possível listar os níveis de acesso');
    }

    return response.body.map<NivelAcessoModel>((nivelAcesso) => NivelAcessoModel.fromJson(nivelAcesso)).toList();
  }

  //Get nivel de acesso by id
  Future<NivelAcessoModel> getNivelAcessoById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'accessLevel/$id',
    );

    if(response.statusCode != 200){
      throw Exception(response.body['error'] ?? 'Não foi possível buscar o nível de acesso');
    }

    NivelAcessoModel nivel = NivelAcessoModel.fromJson(response.body);

    return nivel;
  }

  //Editar nível de acesso
  Future<Map<String, dynamic>> editNivelAcesso(NivelAcessoModel nivel) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel/edit',
      data: nivel.toJson()
    );

    if(response.statusCode != 204){
      return {
        'error': response.body['error'] ?? 'Não foi possível alterar o nível de acesso'
      };
    }

    return {
      'nivelAcesso': nivel
    };
  }

  //Excluir nível de acesso
  Future<String?> deleteNivelAcesso(NivelAcessoModel nivel) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel/delete',
      data: {
        'id': nivel.id
      }
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível excluir o nível de acesso';
    }

    return null;
  }

  //Vincular nível de acesso a usuário
  Future<String?> userLevel(int? userId, int? levelId) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'userLevel',
      data: {
        'userid': userId,
        'levelid': levelId
      }
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível vincular o nível de acesso';
    }

    return null;
  }

  //Desvincular nível de acesso a usuário
  Future<String?> deleteUserLevel(int? userId, int? levelId) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'userLevel/deleteLevel',
      data: {
        'userid': userId,
        'levelid': levelId
      }
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível desvincular o nível de acesso';
    }

    return null;
  }
}
