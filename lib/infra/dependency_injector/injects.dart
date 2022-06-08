import 'package:backend/api/login/login_api.dart';
import 'package:backend/api/news/news_api.dart';
import 'package:backend/api/user/user_api.dart';
import 'package:backend/dao/news_dao.dart';
import 'package:backend/dao/user_dao.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/infra/database/mysql_db_configuration.dart';
import 'package:backend/infra/dependency_injector/dependency_injector.dart';
import 'package:backend/infra/security/security_service.dart';
import 'package:backend/infra/security/security_service_imp.dart';
import 'package:backend/services/login_service.dart';
import 'package:backend/services/news_service.dart';
import 'package:backend/services/user_service.dart';

class Injects {
  static DependencyInjector initialize() {
    var di = DependencyInjector();

    // database injects
    di.register<DBConfiguration>(() => MysqlDBConfiguration());

    // security injects
    di.register<SecurityService>(() => SecurityServiceImp());

    // news api injects
    di.register<NewsDAO>(() => NewsDAO(di.get<DBConfiguration>()));
    di.register<NewsService>(() => NewsService(di.get<NewsDAO>()));
    di.register<NewsApi>(() => NewsApi(di.get()));

    // user api injects
    di.register<UserDAO>(() => UserDAO(di.get<DBConfiguration>()));
    di.register<UserService>(() => UserService(di.get<UserDAO>()));
    di.register<UserApi>(() => UserApi(di.get<UserService>()));

    // login api injects
    di.register<LoginService>(() => LoginService(di.get<UserService>()));
    di.register<LoginApi>(
      () => LoginApi(
        di.get<SecurityService>(),
        di.get<LoginService>(),
      ),
    );
    return di;
  }
}
