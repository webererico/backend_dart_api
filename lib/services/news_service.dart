import 'package:backend/models/news_model.dart';
import 'package:backend/services/base_service.dart';
import 'package:backend/utils/list_extension.dart';

class NewsService implements BaseService<NewsModel> {
  final List<NewsModel> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  List<NewsModel> findAll() {
    return _fakeDB;
  }

  @override
  findOnne(int id) {
    return _fakeDB.firstWhere((element) => element.id == id);
  }

  @override
  bool save(NewsModel value) {
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
