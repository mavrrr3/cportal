import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/platform/network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepository implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;
  final INewsLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  NewsRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, NewsModel>> fetchNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await remoteDataSource.fetchNews();

        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNews = await localDataSource.fetchNewsFromCache();

        return Right(localNews);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
