// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'package:cportal_flutter/domain/entities/article_entity.dart';
import 'dart:convert';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str) as Map<String, dynamic>);

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String id,
    required ArticleTypeEntity articleType,
    required String header,
    required String description,
    required String image,
    required DateTime dateShow,
    required String externalLink,
    required bool show,
    required String userCreated,
    required DateTime dateCreated,
    required String userUpdate,
    required DateTime dateUpdated,
  }) : super(
          id: id,
          articleType: articleType,
          header: header,
          description: description,
          image: image,
          dateShow: dateShow,
          externalLink: externalLink,
          show: show,
          userCreated: userCreated,
          dateCreated: dateCreated,
          userUpdate: userUpdate,
          dateUpdated: dateUpdated,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as String,
        articleType: ArticleTypeModel.fromJson(
          json['article_type'] as Map<String, dynamic>,
        ),
        header: json['header'] as String,
        description: json['description'] as String,
        image: json['image'] as String,
        dateShow: DateTime.parse(json['date_show'] as String),
        externalLink: json['external_link'] as String,
        show: json['show'] as bool,
        userCreated: json['user_created'] as String,
        dateCreated: DateTime.parse(json['date_created'] as String),
        userUpdate: json['user_update'] as String,
        dateUpdated: DateTime.parse(json['date_updated'] as String),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'article_type': (articleType as ArticleTypeModel).toJson(),
        'header': header,
        'description': description,
        'image': image,
        'date_show': dateShow.toIso8601String(),
        'external_link': externalLink,
        'show': show,
        'user_created': userCreated,
        'date_created': dateCreated.toIso8601String(),
        'user_update': userUpdate,
        'date_updated': dateUpdated.toIso8601String(),
      };
}

class ArticleTypeModel extends ArticleTypeEntity {
  const ArticleTypeModel({
    required String id,
    required String code,
    required String description,
  }) : super(
          id: id,
          code: code,
          description: description,
        );

  factory ArticleTypeModel.fromJson(Map<String, dynamic> json) =>
      ArticleTypeModel(
        id: json['id'] as String,
        code: json['code'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'code': code,
        'description': description,
      };
}
