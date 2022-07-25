import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract class INewsRepository {
  Future<Either<Failure, NewsEntity>> fetchNews(int page);
  Future<Either<Failure, NewsEntity>> fetchNewsByCategory(
    int page,
    String category,
  );
  Future<List<String>> fetchNewsCategories();
  Future<Either<Failure, NewsEntity>> fetchQuestions(int page);
  Future<List<String>> fetchQuestionCategories();
  Future<Either<Failure, NewsEntity>> fetchQuestionsByCategory(
    int page,
    String category,
  );
  Future<Either<Failure, ArticleEntity>> getSingleQuestion(String id);
  Future<Either<Failure, ArticleEntity>> getSingleNews(String id);
}
