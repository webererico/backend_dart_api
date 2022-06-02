import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({required Handler router, List<Middleware>? middlewares}) {
    print(middlewares.toString());
    middlewares ??= [];
    Pipeline pipeline = Pipeline();
    for (Middleware middleware in middlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }
    return pipeline.addHandler(router);
  }
}
