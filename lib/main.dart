import 'package:backend/api/blog/blog_api.dart';
import 'package:backend/api/login/login_api.dart';
import 'package:backend/infra/custom_server.dart';
import 'package:shelf/shelf.dart';

void main(List<String> arguments) async {
  var cascadehandler = Cascade().add(LoginApi().handler).add(BlogApi().handler).handler;

  await CustomServer().initialize(cascadehandler);
}
