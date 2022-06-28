import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract class INewsRepository {
  Future<Either<Failure, NewsEntity>> fetchNews(int page);
  Future<Either<Failure, NewsEntity>> fetchNewsByCategory(
    int page,
    String category,
  );
  Future<List<String>> fetchCategories();
  Future<Either<Failure, NewsEntity>> fetchQuastions(int page);
  Future<List<String>> fetchQuastionCategories();
  Future<Either<Failure, NewsEntity>> fetchQuastionsByCategory(
    int page,
    String category,
  );
}
