import 'package:backend/constants/endpoints.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi {
  final SecurityService _securityService;

  LoginApi(this._securityService);

  Handler get handler {
    final Router router = Router();

    router.post(Endpoints.login, (Request req) async {
      return Response.ok(await _securityService.generateJWT('19'));
    });
    return router;
  }
}
