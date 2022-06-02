import 'package:backend/constants/variables.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:backend/utils/custom_env.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userID) async {
    var jwt = JWT({
      'iat': DateTime.now().millisecondsSinceEpoch,
      'user_id': userID,
      'roles': [
        'admin',
        'user',
      ],
    });

    final String key = await CustomEnv.get<String>(key: jwtKey);
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  JWT? validateJWT(String token) {
    throw UnimplementedError();
  }
}
