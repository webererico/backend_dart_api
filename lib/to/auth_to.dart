// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthTo {
  final String email;
  final String password;
  AuthTo({
    required this.email,
    required this.password,
  });

  factory AuthTo.fromRequest(String body) {
    var map = jsonDecode(body);
    return AuthTo(
      email: map['name'],
      password: map['password'],
    );
  }
}
