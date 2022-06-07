// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final int id;
  final String name;
  final String email;
  final bool isActived;
  final DateTime createdAt;
  final DateTime updateAt;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isActived,
    required this.createdAt,
    required this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isActived': isActived,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updateAt': updateAt.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['nome'] as String,
      email: map['email'] as String,
      isActived: map['is_ativo'] == 1,
      createdAt: map['dt_criacao'],
      updateAt: map['dt_autalizacao'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, isActived: $isActived, createdAt: $createdAt, updateAt: $updateAt)';
  }
}
