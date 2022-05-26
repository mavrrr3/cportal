import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  const NewsEntity({
    required this.show,
    required this.article,
  });

  final bool show;
  final List<ArticleEntity> article;

  @override
  List<Object?> get props => [show, article];
}
