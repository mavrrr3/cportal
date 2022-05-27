import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final bool show;
  final List<ArticleEntity> article;

  const NewsEntity({
    required this.show,
    required this.article,
  });

  @override
  List<Object?> get props => [show, article];
}
