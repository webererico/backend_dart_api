import 'dart:convert';

import 'package:backend/api/api.dart';
import 'package:backend/constants/endpoints.dart';
import 'package:backend/models/news_model.dart';
import 'package:backend/services/news_service.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NewsApi extends Api {
  final NewsService _service;

  NewsApi(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.get(Endpoints.news, (Request req) async {
      String? id = req.url.queryParameters['id'];
      if (id == null) return Response(400);
      var news = await _service.findOne(int.parse(id));
      if (news == null) {
        Response(400);
      }
      return Response.ok(jsonEncode(news!.toJson()));
    });

    router.get(Endpoints.allNews, (Request req) async {
      final List<NewsModel> news = await _service.findAll();
      final List<Map> newsFromMap = news.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(newsFromMap));
    });

    router.post(Endpoints.news, (Request req) async {
      var body = await req.readAsString();
      final result = await _service.save(NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.put(Endpoints.news, (Request req) async {
      var body = await req.readAsString();
      var result = await _service.save(NewsModel.fromRequest(jsonDecode(body)));
      return result ? Response(201) : Response(500);
    });

    router.delete(Endpoints.news, (Request req) async {
      int? id = req.url.queryParameters['id'] as int?;
      if (id == null) return Response.badRequest();
      var result = await _service.delete(id);
      return result ? Response(200) : Response.internalServerError();
    });

    return createHandler(
      router: router,
      isSecurity: isSecurity,
      middlewares: middlewares,
    );
  }
}
