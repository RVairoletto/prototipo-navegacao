class NivelAcessoModel {
  int? id;
  String description;

  NivelAcessoModel({
    this.id,
    this.description = '' 
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> retorno = {
      'id': id,
      'description': description,
    };

    return retorno;
  }

  factory NivelAcessoModel.fromJson(Map<String, dynamic> json) {
    return NivelAcessoModel(
      id: json['id'],
      description: json['description'],
    );
  }
}
