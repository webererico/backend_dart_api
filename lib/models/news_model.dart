import 'dart:convert';

class NewsModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime publishDate;
  final DateTime? updateDate;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.publishDate,
    this.updateDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'publishDate': publishDate.millisecondsSinceEpoch,
      'updateDate': updateDate?.millisecondsSinceEpoch,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      publishDate: DateTime.fromMillisecondsSinceEpoch(map['publishDate'] as int),
      updateDate: map['updateDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updateDate'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
