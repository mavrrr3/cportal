import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'dart:convert';

NewsModel newsFromJson(String str) =>
    NewsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String newsToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel extends NewsEntity {
  NewsModel({required bool show, required List<ArticleModel> article})
      : super(show: show, article: article);

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        show: json['show'] as bool,
        article: List<ArticleModel>.from(
          json['article'].map((dynamic x) =>
                  ArticleModel.fromJson(x as Map<String, dynamic>))
              as Iterable<ArticleModel>,
        ),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'show': show,
        'article': List<ArticleModel>.from(
          (article as List<ArticleModel>).map((x) => x.toJson())
              as Iterable<ArticleModel>,
        ),
      };
}
