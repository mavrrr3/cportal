import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryWeb implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;
  final INewsLocalDataSource localDataSource;
  NewsRepositoryWeb({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, NewsModel>> fetchNews(String code) async {
    try {
      final remoteNews = await remoteDataSource.fetchNews(code);

      return Right(remoteNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
