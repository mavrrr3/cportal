import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:hive/hive.dart';

part 'article_model.g.dart';

// ignore_for_file: overridden_fields
// ignore_for_file: annotate_overrides
@HiveType(typeId: 4)
class ArticleModel extends ArticleEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String header;

  @HiveField(4)
  final List<ParagraphModel> content;

  @HiveField(5)
  final String? image;

  const ArticleModel({
    required this.id,
    required this.date,
    required this.category,
    required this.header,
    required this.content,
    required this.image,
  }) : super(
          id: id,
          date: date,
          category: category,
          header: header,
          content: content,
          image: image,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as String,
        date: DateTime.parse(json['date'] as String),
        category: json['category'] as String,
        header: json['header'] as String,
        content: List<ParagraphModel>.from(
          json['Content'].map((dynamic x) =>
                  ParagraphModel.fromJson(x as Map<String, dynamic>))
              as Iterable<dynamic>,
        ),
        image: json['image'] == null
            ? 'https://toto-school.ru/800/600/https/www.caruanacini.com/images/patterns/1995/cromato.jpg'
            : json['image'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'date': date.toIso8601String(),
        'category': category,
        'header': header,
        'Content': List<dynamic>.from(content.map<dynamic>((x) => x.toJson())),
        'image': image,
      };
}

@HiveType(typeId: 5)
class ParagraphModel extends ParagraphEntity {
  @override
  @HiveField(0)
  final String template;
  @override
  @HiveField(1)
  final String? content;
  @override
  @HiveField(2)
  final String? imageTitle;
  @override
  @HiveField(3)
  final String? image;

  const ParagraphModel({
    required this.template,
    required this.content,
    required this.imageTitle,
    required this.image,
  }) : super(
          template: template,
          content: content ?? '',
          imageTitle: imageTitle ?? '',
          image: image ?? '',
        );

  factory ParagraphModel.fromJson(Map<String, dynamic> json) => ParagraphModel(
        template: json['template'] as String,
        content: json['content'] as String?,
        imageTitle: json['image_title'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'template': template,
        'content': content,
        'image_title': imageTitle,
        'image': image,
      };
}
