import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';

class ControllerNiveisAcesso {
  //Post nível de acesso
  Future<String?> postNivelAcesso(String description) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'accessLevel',
      token: '',
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

  //Alterar nivel de acesso
  Future<String?> putNivelAcesso(NivelAcessoModel nivel) async {
    ApiResponse response = await ApiClient().put(
      endPoint: 'accessLevel/${nivel.id}',
      data: nivel.toJson()
    );

    if(response.statusCode != 204){
      return response.body['error'] ?? 'Não foi possível alterar o nível de acesso';
    }

    return null;
  }
}