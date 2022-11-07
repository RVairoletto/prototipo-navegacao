import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';

class ControllerNiveisAcesso {
  //Post nível de acesso
  Future<String?> postNivelAcesso(String description) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel',
      data: {
        'description': description
      }
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível cadastrar o nível de acesso';
    }

    return null;
  }

  //Get níveis de acesso
  Future<List<NivelAcessoModel>> getNiveisAcesso() async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'accessLevel',
    );

    if(response.statusCode != 200){
      throw Exception(response.body['error'] ?? 'Não foi possível listar os níveis de acesso');
    }

    return response.body
        .map<NivelAcessoModel>((nivelAcesso) => NivelAcessoModel.fromJson(nivelAcesso))
        .toList();
  }

  //Get nivel de acesso by id
  Future<NivelAcessoModel> getNivelAcessoById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'accessLevel/$id',
    );

    if(response.statusCode != 200){
      throw Exception(response.body['error'] ?? 'Não foi possível realizar a operação');
    }

    NivelAcessoModel nivel = NivelAcessoModel.fromJson(response.body);

    return nivel;
  }

  //Editar nível de acesso
  Future<String?> editNivelAcesso(NivelAcessoModel nivel) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel/edit',
      data: nivel.toJson()
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível alterar o nível de acesso';
    }

    return null;
  }

  //Excluir nível de acesso
  Future<String?> deleteNivelAcesso(NivelAcessoModel nivel) async {
    //confirmar endpoint
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel/delete',
      data: {
        'id': nivel.id
      }
    );

    //confirmar código de sucesso
    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível excluir o nível de acesso';
    }

    return null;
  }
}
