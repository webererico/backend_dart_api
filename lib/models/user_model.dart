// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  bool? isActived;
  DateTime? createdAt;
  DateTime? updateAt;

  UserModel();

  UserModel.create({
    this.id,
    this.name,
    this.email,
    this.isActived,
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'isActived': isActived,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updateAt': updateAt?.millisecondsSinceEpoch,
    };
  }

  factory UserModel.fromRequest(Map map) {
    return UserModel()
      ..name = map['name']
      ..email = map['email']
      ..password = map['password'];
  }

  factory UserModel.fromEmail(Map map) {
    return UserModel()
      ..id = map['id']?.toInt()
      ..password = map['password'];
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel.create(
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
