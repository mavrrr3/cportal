import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract class INewsRepository {
  Future<Either<Failure, NewsEntity>> fetchNews(int page, String? category);
}
