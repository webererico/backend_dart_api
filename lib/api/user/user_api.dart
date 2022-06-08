import 'dart:convert';

import 'package:backend/api/api.dart';
import 'package:backend/constants/endpoints.dart';
import 'package:backend/models/user_model.dart';
import 'package:backend/services/user_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class UserApi extends Api {
  final UserService _userService;
  UserApi(this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    final router = Router();

    router.post(Endpoints.user, (Request req) async {
      var body = await req.readAsString();
      if (body.isEmpty) return Response(400);
      final UserModel user = UserModel.fromRequest(jsonDecode(body));
      var result = await _userService.save(user);
      return result ? Response(201) : Response(500);
    });

    router.get(Endpoints.user, (Request req) async {
      return Response.ok(jsonEncode(await _userService.findAll()));
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
