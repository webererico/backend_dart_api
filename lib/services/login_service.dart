import 'dart:developer';

import 'package:backend/services/user_service.dart';
import 'package:backend/to/auth_to.dart';
import 'package:password_dart/password_dart.dart';

class LoginService {
  final UserService _userService;
  LoginService(this._userService);

  Future<int> authenticate(AuthTo to) async {
    try {
      var user = await _userService.findByEmail(to.email);
      if (user == null) {
        return -1;
      }
      return Password.verify(to.password, user.password!) ? user.id! : -1;
    } catch (e) {
      log('[ERROR] -> in Authenticate method by email ${to.email}');
    }
    return -1;
  }
}
