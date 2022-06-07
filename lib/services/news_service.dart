import 'package:backend/models/news_model.dart';
import 'package:backend/services/base_service.dart';
import 'package:backend/utils/list_extension.dart';

class NewsService implements BaseService<NewsModel> {
  final List<NewsModel> _fakeDB = [];

  @override
  Future<bool> delete(int id) async {
    _fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  Future<List<NewsModel>> findAll() async {
    return _fakeDB;
  }

  @override
  Future<NewsModel?> findOne(int id) async {
    return _fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  Future<bool> save(NewsModel value) async {
    NewsModel? news = _fakeDB.firstWhereOrNull((element) => element == value);
    if (news == null) {
      _fakeDB.add(value);
    } else {
      int index = _fakeDB.indexOf(news);
      _fakeDB[index] = value;
    }
    return true;
  }
}
