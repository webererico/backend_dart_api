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
  var cascadehandler =
      Cascade().add(LoginApi(SecurityServiceImp()).handler).add(BlogApi(NewsService()).handler).handler;
  var handler = Pipeline()
      .addMiddleware(MiddlewareInterception().middleware)
      .addMiddleware(
        logRequests(),
      )
      .addHandler(cascadehandler);
  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: serverAddress),
    port: await CustomEnv.get<int>(key: serverPort),
  );
}
