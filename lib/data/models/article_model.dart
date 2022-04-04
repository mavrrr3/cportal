// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'package:cportal_flutter/domain/entities/article_entity.dart';
import 'dart:convert';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required id,
    required articleType,
    required header,
    required description,
    required image,
    required dateShow,
    required externalLink,
    required show,
    required userCreated,
    required dateCreated,
    required userUpdate,
    required dateUpdated,
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
        id: json['id'],
        articleType: ArticleTypeModel.fromJson(json['article_type']),
        header: json['header'],
        description: json['description'],
        image: json['image'],
        dateShow: DateTime.parse(json['date_show']),
        externalLink: json['external_link'],
        show: json['show'],
        userCreated: json['user_created'],
        dateCreated: DateTime.parse(json['date_created']),
        userUpdate: json['user_update'],
        dateUpdated: DateTime.parse(json['date_updated']),
      );

  Map<String, dynamic> toJson() => {
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
  ArticleTypeModel({
    required id,
    required code,
    required description,
  }) : super(
          id: id,
          code: code,
          description: description,
        );

  factory ArticleTypeModel.fromJson(Map<String, dynamic> json) =>
      ArticleTypeModel(
        id: json['id'],
        code: json['code'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'description': description,
      };
}
