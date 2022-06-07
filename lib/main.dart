import 'package:backend/api/blog/blog_api.dart';
import 'package:backend/api/login/login_api.dart';
import 'package:backend/api/user/user_api.dart';
import 'package:backend/constants/variables.dart';
import 'package:backend/infra/custom_server.dart';
import 'package:backend/infra/dependency_injector/injects.dart';
import 'package:backend/infra/middleware_interception.dart';
import 'package:backend/utils/custom_env.dart';
import 'package:shelf/shelf.dart';

void main(List<String> arguments) async {
  var di = Injects.initialize();
  var cascadeHandler = Cascade()
      .add(di.get<LoginApi>().getHandler())
      .add(di.get<BlogApi>().getHandler())
      .add(di.get<UserApi>().getHandler(isSecurity: true))
      .handler;
  var handler = Pipeline().addMiddleware(MiddlewareInterception().middleware).addHandler(cascadeHandler);
  await CustomServer().initialize(
    handler: handler,
    address: await CustomEnv.get<String>(key: serverAddress),
    port: await CustomEnv.get<int>(key: serverPort),
  );
}
