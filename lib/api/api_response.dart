//Classe para receber as respostas de API
class ApiResponse {
  int statusCode;
  dynamic body;
  Map<String, dynamic>? header;

  ApiResponse({
    this.statusCode = 0,
    required this.body,
    this.header,
  });
}
