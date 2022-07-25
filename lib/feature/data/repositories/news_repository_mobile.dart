import 'package:cportal_flutter/core/error/cache_exception.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/platform/i_network_info.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/article_entity.dart';
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
  Future<List<String>> fetchNewsCategories() async {
    final localNews = await localDataSource.fetchNewsFromCache();

    return localNews.response.categories ?? [];
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchQuestions(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuestions = await remoteDataSource.fetchQuestions(page);

        return Right(remoteQuestions);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localQuestions = await localDataSource.fetchQuestionsFromCache();

        return Right(localQuestions);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<List<String>> fetchQuestionCategories() async {
    final localNews = await localDataSource.fetchQuestionsFromCache();

    return localNews.response.categories ?? [];
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchQuestionsByCategory(
    int page,
    String category,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuestionsByCategory =
            await remoteDataSource.fetchQuestionsByCategory(page, category);

        return Right(remoteQuestionsByCategory);
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
  Future<Either<Failure, ArticleEntity>> getSingleNews(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSingleNews = await remoteDataSource.getSingleNews(id);

        return Right(remoteSingleNews);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSingleNews =
            await localDataSource.getSingleNewsFromCache(id);

        return Right(localSingleNews);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, ArticleEntity>> getSingleQuestion(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSingleQuastion =
            await remoteDataSource.getSingleQuestion(id);

        return Right(remoteSingleQuastion);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSingleQuastion =
            await localDataSource.getSingleQuestionFromCache(id);

        return Right(localSingleQuastion);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
