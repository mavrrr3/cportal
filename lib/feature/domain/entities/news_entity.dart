import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';

class NewsEntity {
  NewsEntity({
    required this.show,
    required this.article,
  });

  final bool show;
  final List<ArticleEntity> article;
}
