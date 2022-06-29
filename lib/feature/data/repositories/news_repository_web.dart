import 'dart:developer';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/domain/entities/news_entity.dart';
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
  Future<Either<Failure, NewsModel>> fetchNews(
    int page,
  ) async {
    try {
      final remoteNews = await remoteDataSource.fetchNews(page);
      log('NewsRepositoryWeb $remoteNews');

      return Right(remoteNews);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchNewsByCategory(
    int page,
    String category,
  ) async {
    try {
      final remoteNewsByCategory =
          await remoteDataSource.fetchNewsByCategory(page, category);

      return Right(remoteNewsByCategory);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<List<String>> fetchCategories() async {
    final localNews = await localDataSource.fetchNewsFromCache();

    return localNews.response.categories ?? [];
  }

  @override
  Future<List<String>> fetchQuestionCategories() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchQuestions(int page) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, NewsEntity>> fetchQuestionsByCategory(
    int page,
    String category,
  ) async {
    try {
      final remoteQuestionsByCategory =
          await remoteDataSource.fetchQuestionsByCategory(page, category);

      return Right(remoteQuestionsByCategory);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
