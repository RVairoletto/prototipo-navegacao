class Permission {
  int? id;
  int? levelId;
  int? menuId;

  Permission({
    this.id,
    this.levelId,
    this.menuId
  });

  Map<String, dynamic> toJson() {
    return{
      'id': id,
      'levelId': levelId,
      'menuId': menuId,
    };
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      levelId: json['levelId'],
      menuId: json['menuId'],
    );
  }
}
