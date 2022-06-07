import 'package:backend/constants/queries.dart';
import 'package:backend/dao/dao.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/models/user_model.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  _execQuery(String sql, [List? params]) async {
    final connection = await _dbConfiguration.connection;
    return await connection.query(sql, params);
  }

  @override
  Future<bool> create(UserModel value) async {
    final result = await _execQuery(
      Queries.insertUser,
      [
        value.name,
        value.email,
        value.password,
      ],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final result = await _execQuery(Queries.deleteUser, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final result = await _execQuery(Queries.findAllUsers);
    return result.map((r) => UserModel.fromMap(r.fields)).toList().cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    final result = await _execQuery(Queries.findOneUser, [id]);
    return result.affectedRows == 0 ? null : UserModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    final result = await _execQuery(
      Queries.updateUser,
      [
        value.name,
        value.password,
        value.id,
      ],
    );

    return result.affectedRows > 0;
  }
}
