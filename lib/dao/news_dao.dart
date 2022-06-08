import 'package:backend/constants/queries.dart';
import 'package:backend/dao/dao.dart';
import 'package:backend/infra/database/db_configuration.dart';
import 'package:backend/models/news_model.dart';

class NewsDAO implements DAO<NewsModel> {
  final DBConfiguration _dbConfiguration;

  NewsDAO(this._dbConfiguration);

  @override
  Future<bool> create(NewsModel value) async {
    final result = await _dbConfiguration.execQuery(
      Queries.insertNews,
      [
        value.title,
        value.description,
        value.userId,
      ],
    );

    return result.affectedRows > 0;
  }

  @override
  Future<bool> delete(int id) async {
    final result = await _dbConfiguration.execQuery(Queries.deleteNews, [id]);
    return result.affectedRows > 0;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    final result = await _dbConfiguration.execQuery(Queries.findAllNews);
    return result.map((r) => NewsModel.fromMap(r.fields)).toList().cast<NewsModel>();
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    final result = await _dbConfiguration.execQuery(Queries.findOneNews, [id]);
    return result.isEmpty ? null : NewsModel.fromMap(result.first.fields);
  }

  @override
  Future<bool> update(NewsModel value) async {
    final result = await _dbConfiguration.execQuery(
      Queries.updateNews,
      [
        value.title,
        value.description,
        value.id,
        value.userId,
      ],
    );

    return result.affectedRows > 0;
  }
}
