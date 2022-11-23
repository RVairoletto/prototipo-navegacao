import 'package:prototipo_navegacao/api/api_client.dart';
import 'package:prototipo_navegacao/api/api_response.dart';
import 'package:prototipo_navegacao/widgets/drawer_menu_items.dart';

//Classe de controller responsável pelas operações de menu
class ControllerMenus {
  //Post menu
  //Recomenda-se usar essa rotina para otimizar o cadastro manual
  //De itens de menu no banco de dados
  Future<String?> postMenu(DrawerMenuItem menuItem) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'menu',
      data: menuItem.toJson()
    );

    if (response.statusCode != 204) {
      return response.body['error'] ?? 'Não foi possível cadastrar o item de menu';
    }

    return null;
  }

  //Get menus
  Future<List<DrawerMenuItem>> getMenus() async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'menu',
    );

    if (response.statusCode != 200) {
      throw Exception(response.body['error'] ?? 'Não foi possível buscar os itens de menu');
    }

    return response.body.map<DrawerMenuItem>((menuItem) {
      return DrawerMenuItem.fromJson(menuItem);
    }).toList();
  }

  //Edit menu
  Future<String?> editMenu(DrawerMenuItem menuItem) async {
    ApiResponse response = await ApiClient().post(
      endPoint: 'menu/edit',
      data: menuItem.toJson()
    );

    if (response.statusCode != 204) {
      return response.body['error'] ?? 'Não foi possível editar o item de menu';
    }

    return null;
  }

  //Get menu by id
  Future<DrawerMenuItem?> getMenuById(int id) async {
    ApiResponse response = await ApiClient().get(
      endPoint: 'menu/$id',
    );

    if (response.statusCode != 204) {
      return null;
    }

    return DrawerMenuItem.fromJson(response.body);
  }
}
