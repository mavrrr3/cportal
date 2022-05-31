import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String id;
  final DateTime date;
  final String category;
  final String header;
  final List<ParagraphEntity> content;
  final String image;
  const ArticleEntity({
    required this.id,
    required this.date,
    required this.category,
    required this.header,
    required this.content,
    required this.image,
  });

  @override
  List<Object?> get props => [id, date, category, header, content, image];
}

class ParagraphEntity extends Equatable {
  final String template;
  final String content;
  final String imagesTitle;
  final String images;

  const ParagraphEntity({
    required this.template,
    required this.content,
    required this.imagesTitle,
    required this.images,
  });

  @override
  List<Object?> get props => [template, content, imagesTitle, images];
}
