class NewsModel {
  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;

  NewsModel();

  factory NewsModel.fromMap(Map map) {
    return NewsModel()
      ..id = map['id']?.toInt()
      ..title = map['titulo']
      ..description = map['descricao'].toString()
      ..createdAt = map['dt_criacao']
      ..updatedAt = map['dt_atualizacao']
      ..userId = map['id_usuario']?.toInt();
  }

  factory NewsModel.fromRequest(Map map) {
    return NewsModel()
      ..id = map['id']
      ..title = map['title']
      ..description = map['description']
      ..userId = map['userId']?.toInt();
  }

  Map toJson() => {'id': id, 'titulo': title, 'descricao': description};

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId)';
  }
}
