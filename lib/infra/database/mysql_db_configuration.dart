import 'package:backend/constants/variables.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/utils/custom_env.dart';
import 'package:mysql1/mysql1.dart';

class MysqlDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async => _connection ??= _connection = await createConnection();

  @override
  Future<MySqlConnection> createConnection() async {
    return await MySqlConnection.connect(
      ConnectionSettings(
        host: await CustomEnv.get<String>(key: dbHost),
        port: await CustomEnv.get<int>(key: dbPort),
        user: await CustomEnv.get<String>(key: dbUser),
        password: await CustomEnv.get<String>(key: dbPass),
        db: await CustomEnv.get<String>(key: dbSchema),
      ),
    );
  }

  @override
  execQuery(String sql, [List? params]) async {
    var conn = await connection;
    return await conn.query(sql, params);
  }
}
