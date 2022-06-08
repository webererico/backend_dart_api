import 'package:backend/infra/dependency_injector/dependency_injector.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({
    List<Middleware>? middlewares,
    bool isSecurity = false,
  });

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
    bool isSecurity = false,
  }) {
    middlewares ??= [];
    if (isSecurity) {
      var securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        securityService.authorization,
        securityService.verifyJWT,
      ]);
    }
    Pipeline pipeline = Pipeline();
    for (Middleware middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }
    return pipeline.addHandler(router);
  }
}
