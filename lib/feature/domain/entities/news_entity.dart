import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final ResponseEntity response;

  const NewsEntity({required this.response});

  @override
  List<Object?> get props => [response];
}

class ResponseEntity extends Equatable {
  final int count;
  final int update;
  final List<String>? categories;
  final List<ArticleEntity> articles;

  const ResponseEntity({
    required this.count,
    required this.update,
    required this.categories,
    required this.articles,
  });

  @override
  List<Object?> get props => [count, update, categories, articles];
}
