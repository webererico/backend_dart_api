import 'dart:convert';

import 'package:backend/api/api.dart';
import 'package:backend/constants/endpoints.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:backend/services/login_service.dart';
import 'package:backend/to/auth_to.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  final LoginService _loginService;

  LoginApi(this._securityService, this._loginService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    final Router router = Router();
    router.post(
      Endpoints.login,
      (Request req) async {
        var body = await req.readAsString();
        var authTO = AuthTo.fromRequest(body);
        var userId = await _loginService.authenticate(authTO);
        if (userId > 0) {
          var jwt = await _securityService.generateJWT(userId.toString());
          return Response.ok(
            jsonEncode({'token': jwt}),
          );
        } else {
          return Response(401);
        }
      },
    );
    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
