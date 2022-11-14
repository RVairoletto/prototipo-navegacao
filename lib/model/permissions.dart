class Permission {
  int? id;
  int? levelId;
  int? menuId;
  String description;

  Permission({
    this.id,
    this.levelId,
    this.menuId,
    this.description = '',
  });

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'levelId': levelId,
      'menuId': menuId,
      'description': description
    };
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      levelId: json['levelid'],
      menuId: json['menuid'],
      description: json['description'],
    );
  }
}
