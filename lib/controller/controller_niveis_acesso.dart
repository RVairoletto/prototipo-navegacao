import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/model/nivel_acesso.dart';

class ControllerNiveisAcesso {
  //Post nível de acesso
  Future<String?> postNivelAcesso(String description) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'acessLevel',
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
      endPoint: 'acessLevel',
    );

    if(response.statusCode != 204){
      throw Exception(response.body['error'] ?? 'Não foi possível listar os níveis de acesso');
    }

    return response.body
        .map<NivelAcessoModel>((nivelAcesso) => NivelAcessoModel.fromJson(nivelAcesso))
        .toList();
  }
}
