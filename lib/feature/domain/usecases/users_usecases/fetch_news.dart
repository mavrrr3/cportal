import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cportal_flutter/core/error/failure.dart';

class FetchNewsUseCase {
  final INewsRepository newsRepository;

  FetchNewsUseCase(this.newsRepository);

  Future<Either<Failure, NewsEntity>> call() async {
    return await newsRepository.fetchNews();
  }
}
