import 'package:backend/api/blog/blog_api.dart';
import 'package:backend/api/login/login_api.dart';
import 'package:backend/constants/variables.dart';
import 'package:backend/infra/custom_server.dart';
import 'package:backend/infra/middleware_interception.dart';
import 'package:backend/infra/security/security_service_imp.dart';
import 'package:backend/services/news_service.dart';
import 'package:backend/utils/custom_env.dart';
import 'package:shelf/shelf.dart';

void main(List<String> arguments) async {
  final SecurityServiceImp securityService = SecurityServiceImp();

  var cascadehandler = Cascade()
      .add(LoginApi(securityService).getHandler())
      .add(
        BlogApi(NewsService()).getHandler(
          middlewares: [
            // securityService.authorization,
            // securityService.verifyJWT,
          ],
        ),
      )
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().middleware)
      .addHandler(cascadehandler);
  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: serverAddress),
    port: await CustomEnv.get<int>(key: serverPort),
  );
}
