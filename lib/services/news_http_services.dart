import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsHttpServices {
  Future<List<News>> getInformation(String searchNews) async {
    if (searchNews.isEmpty) {
      searchNews = "tesla";
    }
    searchNews = searchNews.trim().toLowerCase();
    DateTime dateBox = DateTime.now().subtract(const Duration(days: 30));
    String date = dateBox.toString().split(" ")[0];
    Uri url = Uri.parse(
        "https://newsapi.org/v2/everything?q=$searchNews&language=en&from=$date&sortBy=publishedAt&apiKey=d347c70c66d04c00b5c0d037f647d727");
    List<News> loadedNews = [];
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    saveNews(searchNews);

    for (var value in data['articles']) {
      if (value['source'] == null ||
          value['author'] == null ||
          value['title'] == null ||
          value['description'] == null ||
          value['url'] == null ||
          value['urlToImage'] == null ||
          value['publishedAt'] == null ||
          value['content'] == null) {
        continue;
      }

      // Rasm URL manzilining kengaytmasini tekshirish
      final imageUrl = value['urlToImage'];
      if (!_isValidImageUrl(imageUrl)) {
        continue;
      }

      loadedNews.add(News.fromJson(value));
    }

    return loadedNews;
  }

  bool _isValidImageUrl(String url) {
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    final uri = Uri.parse(url);
    final extension = uri.path.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }
}

Future<void> saveNews(String news) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('news', news);
}
