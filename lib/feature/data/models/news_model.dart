// ignore_for_file: overridden_fields
// import 'dart:convert';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:hive/hive.dart';

part 'news_model.g.dart';

// NewsModel newsModelFromJson(String str) =>
//     NewsModel.fromJson(json.decode(str) as Map<String, dynamic>);

// String newsModelToJson(NewsModel data) => json.encode(data.toJson());

@HiveType(typeId: 7)
class NewsModel extends NewsEntity {
  @override
  @HiveField(0)
  final ResponseModel response;
  const NewsModel({
    required this.response,
  }) : super(
          response: response,
        );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        response:
            ResponseModel.fromJson(json['response'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'response': response.toJson(),
      };
}

@HiveType(typeId: 11)
class ResponseModel extends ResponseEntity {
  @override
  @HiveField(0)
  final int count;
  @override
  @HiveField(1)
  final int update;
  @override
  @HiveField(2)
  final List<String>? categories;
  @override
  @HiveField(3)
  final List<ArticleModel> articles;

  const ResponseModel({
    required this.count,
    required this.update,
    required this.categories,
    required this.articles,
  }) : super(
          count: count,
          update: update,
          categories: categories,
          articles: articles,
        );

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        count: json['count'] as int,
        update: json['update'] as int,
        categories: List<String>.from(json['categories']
            .map((dynamic x) => x as String) as Iterable<dynamic>),
        articles: List<ArticleModel>.from(
          json['items'].map((dynamic x) =>
                  ArticleModel.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'update': update,
        'categories': categories,
        'items': List<dynamic>.from(articles.map<dynamic>((x) => x.toJson())),
      };
}
