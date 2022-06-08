import 'package:backend/constants/messages.dart';
import 'package:backend/constants/variables.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:backend/utils/custom_env.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    final JWT jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'user_id': userID,
      'roles': [
        'admin',
        'user',
      ],
    });

    final String token = jwt.sign(SecretKey(await _recoverKey));

    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    try {
      return JWT.verify(token, SecretKey(await _recoverKey));
    } on JWTInvalidError {
      return null;
    } on JWTExpiredError {
      return null;
    } on JWTNotActiveError {
      return null;
    } on JWTUndefinedError {
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String> get _recoverKey async => await CustomEnv.get<String>(key: jwtSecretKey);

  @override
  Middleware get authorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers[headerKey];
        JWT? jwt;
        if (authorizationHeader != null) {
          if (authorizationHeader.contains(jwtAuthorizationHeader)) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var request = req.change(context: {jwtKey: jwt});
        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT {
    return createMiddleware(
      requestHandler: (Request req) {
        if (req.context[jwtKey] == null) {
          return Response.forbidden(ApiMessages.forbidden);
        }
        return null;
      },
    );
  }
}
