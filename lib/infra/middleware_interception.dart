import 'package:backend/constants/variables.dart';
import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  static Middleware get contentTypeJson {
    return createMiddleware(
      responseHandler: (Response res) => res.change(
        headers: middlewareHeader,
      ),
    );
  }

  static Middleware get cors {
    Response addCorsHeader(Response res) => res.change(headers: headersPermitted);

    return createMiddleware(requestHandler: handlerOption, responseHandler: addCorsHeader);
  }
}

Response? handlerOption(Request req) {
  if (req.method == optionMethod) {
    return Response(200, headers: headersPermitted);
  }
  return null;
}
