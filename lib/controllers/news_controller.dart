import 'package:news/models/news.dart';
import 'package:news/services/news_http_services.dart';

class NewsController {
  final newsHttpServices = NewsHttpServices();

  Future<List<News>> getInformation(String searchNews) async {
    List<News> news = await newsHttpServices.getInformation(searchNews);

    return news;
  }
}