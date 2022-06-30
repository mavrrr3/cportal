import 'dart:convert';
import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNewsByCategory(int page, String category);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchQuestions(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchQuestionsByCategory(int page, String category);
}

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;
  final Dio dio;

  NewsRemoteDataSource(this.localDatasource, this.dio);

  @override
  Future<NewsModel> fetchNews(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page';

    try {
      final response = await dio.get<String>(baseUrl);

      // Log('NewsRemoteDataSource ${response.data}');.
      final news = NewsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      await localDatasource.newsToCache(news);

      return news;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<NewsModel> fetchNewsByCategory(int page, String category) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page&category=$category';

    try {
      final response = await dio.get<String>(baseUrl);

      final newsByCategory = NewsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      await localDatasource.newsByCategoryToCache(newsByCategory, category);

      return newsByCategory;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<NewsModel> fetchQuestions(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/faq/1.0/?page=$page';

    try {
      log('Такой эндпойнт $baseUrl');
      final response = await dio.get<String>(baseUrl);
      final news = NewsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );
      log('загрузилось статей ${news.response.articles.length}');

      await localDatasource.newsToCache(news);

      return news;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<NewsModel> fetchQuestionsByCategory(int page, String category) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/faq/1.0/?page=$page&category=$category';
    log('page=$page category=$category baseUrl $baseUrl');

    try {
      final response = await dio.get<String>(baseUrl);

      final newsByCategory = NewsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      await localDatasource.newsByCategoryToCache(newsByCategory, category);

      return newsByCategory;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
