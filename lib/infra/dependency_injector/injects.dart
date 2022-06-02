import 'package:backend/api/blog/blog_api.dart';
import 'package:backend/api/login/login_api.dart';
import 'package:backend/infra/dependency_injector/dependency_injector.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:backend/infra/security/security_service_imp.dart';
import 'package:backend/services/news_service.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    di.register<SecurityService>(() => SecurityServiceImp());

    di.register<LoginApi>(() => LoginApi(di.get()));
    di.register<NewsService>(() => NewsService());
    di.register<BlogApi>(() => BlogApi(di.get()));

    return di;
  }
}
