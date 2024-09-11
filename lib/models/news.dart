import 'package:json_annotation/json_annotation.dart';
part 'news.g.dart';

@JsonSerializable()
class News {
  Map source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return _$NewsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NewsToJson(this);
  }
}
