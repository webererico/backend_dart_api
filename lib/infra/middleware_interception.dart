import 'package:backend/constants/variables.dart';
import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get middleware {
    return createMiddleware(
      responseHandler: (Response res) => res.change(
        headers: middlewareHeader,
      ),
    );
  }
}
