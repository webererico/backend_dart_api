import 'package:backend/constants/queries.dart';
import 'package:backend/dao/dao.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/models/user_model.dart';

class UserDAO implements DAO<UserModel> {
  final DBConfiguration _dbConfiguration;
  UserDAO(this._dbConfiguration);

  @override
  Future<bool> create(UserModel value) async {
    final result = await _dbConfiguration.execQuery(
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
    final result = await _dbConfiguration.execQuery(Queries.deleteUser, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<UserModel>> findAll() async {
    final result = await _dbConfiguration.execQuery(Queries.findAllUsers);
    return result.map((r) => UserModel.fromMap(r.fields)).toList().cast<UserModel>();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    final result = await _dbConfiguration.execQuery(Queries.findOneUser, [id]);
    return result.affectedRows == 0 ? null : UserModel.fromMap(result.first.fields);
  }

  Future<UserModel?> findByEmail(String email) async {
    final result = await _dbConfiguration.execQuery(Queries.findUserByEmail, [email]);
    return result.affectedRows == 0 ? null : UserModel.fromEmail(result.first.fields);
  }

  @override
  Future<bool> update(UserModel value) async {
    final result = await _dbConfiguration.execQuery(
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
