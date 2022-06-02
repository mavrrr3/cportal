import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryWeb implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;

  NewsRepositoryWeb({
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, NewsModel>> fetchNews(
    int page,
    String? category,
  ) async {
    try {
      final remoteNews = await remoteDataSource.fetchNews(page, category);

      return Right(remoteNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
