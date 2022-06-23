import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_news_repository.dart';
import 'package:dartz/dartz.dart';

class NewsRepositoryMobile implements INewsRepository {
  final INewsRemoteDataSource remoteDataSource;
  final INewsLocalDataSource localDataSource;
  final INetworkInfo networkInfo;

  NewsRepositoryMobile({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, NewsModel>> fetchNews(
    int page,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNews = await remoteDataSource.fetchNews(page);

        return Right(remoteNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNews = await localDataSource.fetchNewsFromCache();

        return Right(localNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchNewsByCategory(
    int page,
    String category,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteNewsByCategory =
            await remoteDataSource.fetchNewsByCategory(page, category);

        return Right(remoteNewsByCategory);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localNewsByCtegory =
            await localDataSource.fetchNewsByCategoryFromCache(category);

        return Right(localNewsByCtegory);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<List<String>> fetchCategories() async {
    final localNews = await localDataSource.fetchNewsFromCache();

    return localNews.response.categories ?? [];
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchQuastions(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuastions = await remoteDataSource.fetchQuastions(page);

        return Right(remoteQuastions);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuastions = await localDataSource.fetchQuastionsFromCache();

        return Right(localQuastions);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<List<String>> fetchQuastionCategories() {
    throw UnimplementedError();
  }
}
