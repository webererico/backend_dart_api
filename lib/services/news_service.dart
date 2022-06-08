import 'package:backend/dao/news_dao.dart';
import 'package:backend/models/news_model.dart';
import 'package:backend/services/base_service.dart';

class NewsService implements BaseService<NewsModel> {
  final NewsDAO _newsDAO;
  NewsService(this._newsDAO);

  @override
  Future<bool> delete(int id) async => await _newsDAO.delete(id);

  @override
  Future<List<NewsModel>> findAll() async => await _newsDAO.findAll();

  @override
  Future<NewsModel?> findOne(int id) async => await _newsDAO.findOne(id);

  @override
  Future<bool> save(NewsModel value) async =>
      value.id != null ? await _newsDAO.update(value) : await _newsDAO.create(value);
}
