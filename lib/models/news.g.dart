// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      source: json['source'] as Map<String, dynamic>? ?? {},
      author: json['author'] as String? ?? "",
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      url: json['url'] as String? ?? "",
      urlToImage: json['urlToImage'] as String? ?? "",
      publishedAt: DateTime.parse(json['publishedAt'] as String? ?? DateTime.now().toString()),
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'content': instance.content,
    };
