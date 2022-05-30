import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

part 'news_model.g.dart';

// ignore_for_file: annotate_overrides, overridden_fields

NewsModel newsFromJson(String str) =>
    NewsModel.fromJson(json.decode(str) as Map<String, dynamic>);

String newsToJson(NewsModel data) => json.encode(data.toJson());

@HiveType(typeId: 7)
class NewsModel extends NewsEntity {
  @HiveField(0)
  final bool show;

  @HiveField(1)
  final List<ArticleModel> article;
  const NewsModel({
    required this.show,
    required this.article,
  }) : super(
          show: show,
          article: article,
        );

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
          article.map((x) => x.toJson()) as Iterable<ArticleModel>,
        ),
      };
}
