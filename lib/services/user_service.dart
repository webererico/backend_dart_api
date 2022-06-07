import 'package:backend/dao/user_dao.dart';
import 'package:backend/models/user_model.dart';
import 'package:backend/services/base_service.dart';

class UserService implements BaseService<UserModel> {
  final UserDAO _userDAO;

  UserService(this._userDAO);

  @override
  Future<bool> delete(int id) async {
    return await _userDAO.delete(id);
  }

  @override
  Future<List<UserModel>> findAll() async {
    return _userDAO.findAll();
  }

  @override
  Future<UserModel?> findOne(int id) async {
    return _userDAO.findOne(id);
  }

  @override
  Future<bool> save(UserModel value) async {
    if (value.id != null) {
      return await _userDAO.update(value);
    }
    return await _userDAO.create(value);
  }
}
