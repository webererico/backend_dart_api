import 'package:backend/constants/queries.dart';
import 'package:backend/dao/dao.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/models/user_model.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future create(UserModel value) async {
    throw UnimplementedError();
  }

  @override
  Future delete(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> findAll() async {
    final connection = await _dbConfiguration.connection;
    final result = await connection.query(Queries.findAllUsers);
    final List<UserModel> users = [];
    for (var r in result) {
      users.add(UserModel.fromMap(r.fields));
    }
    return users;
  }

  @override
  Future<UserModel> findOne(int id) async {
    final connection = await _dbConfiguration.connection;
    final result = await connection.query(Queries.findOneUser, [id]);
    if (result.length <= 0) throw ('[ERROR DB] findOne for $id, not found.');
    return UserModel.fromMap(result.first.fields);
  }

  @override
  Future update(UserModel value) async {
    throw UnimplementedError();
  }
}
