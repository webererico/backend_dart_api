import 'package:backend/api/api.dart';
import 'package:backend/constants/endpoints.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class LoginApi extends Api {
  final SecurityService _securityService;
  LoginApi(this._securityService);

  @override
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    final Router router = Router();
    router.post(
      Endpoints.login,
      (Request req) async {
        String token = await _securityService.generateJWT('1');
        return Response.ok(token);
      },
    );
    return createHandler(
      router: router,
      middlewares: middlewares,
      isSecurity: isSecurity,
    );
  }
}
