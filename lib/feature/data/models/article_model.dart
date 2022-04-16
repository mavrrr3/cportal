// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'dart:convert';
import 'package:hive/hive.dart';

part 'article_model.g.dart';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str) as Map<String, dynamic>);

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());
// ignore_for_file: annotate_overrides, overridden_fields

@HiveType(typeId: 5)
class ArticleModel extends ArticleEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final ArticleTypeEntity articleType;
  @HiveField(2)
  final String header;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final DateTime dateShow;
  @HiveField(6)
  final String externalLink;
  @HiveField(7)
  final bool show;
  @HiveField(8)
  final String userCreated;
  @HiveField(9)
  final DateTime dateCreated;
  @HiveField(10)
  final String userUpdate;
  @HiveField(11)
  final DateTime dateUpdated;

  const ArticleModel({
    required final this.id,
    required final this.articleType,
    required final this.header,
    required final this.description,
    required final this.image,
    required final this.dateShow,
    required final this.externalLink,
    required final this.show,
    required final this.userCreated,
    required final this.dateCreated,
    required final this.userUpdate,
    required final this.dateUpdated,
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

@HiveType(typeId: 6)
class ArticleTypeModel extends ArticleTypeEntity {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final String description;

  const ArticleTypeModel({
    required final this.id,
    required final this.code,
    required final this.description,
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
