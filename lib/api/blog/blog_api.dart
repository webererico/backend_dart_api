import 'dart:convert';

import 'package:backend/constants/endpoints.dart';
import 'package:backend/models/news_model.dart';
import 'package:backend/services/base_service.dart';
import 'package:backend/services/news_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogApi {
  final NewsService _service;

  BlogApi(this._service);

  Handler get handler {
    Router router = Router();

    router.get(Endpoints.blog, (Request req) {
      final List<NewsModel> news = _service.findAll();
      final List<Map> newsFromMap = news.map((e) => e.toMap()).toList();
      return Response.ok(jsonEncode(newsFromMap));
    });

    router.post(Endpoints.blog, (Request req) async {
      var body = await req.readAsString();
      _service.save(NewsModel.fromJson(jsonDecode(body)));
      return Response(201);
    });

    router.put(Endpoints.blog, (Request req) {
      String? id = req.url.queryParameters['id'];
      // _service.save('');
      return Response.ok('Rain Today $id');
    });

    router.delete(Endpoints.blog, (Request req) {
      int? id = req.url.queryParameters['id'] as int;
      _service.delete(id);
      return Response.ok('Rain deleted');
    });

    return router;
  }
}
