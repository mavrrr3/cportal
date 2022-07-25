import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_news_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;
  final Dio _dio;

  NewsRemoteDataSource(this.localDatasource, this._dio);

  @override
  Future<NewsModel> fetchNews(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final news = NewsModel.fromJson(response.data!);

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
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final newsByCategory = NewsModel.fromJson(response.data!);

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
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );
      final questions = NewsModel.fromJson(response.data!);
      log('загрузилось вопросов ${questions.response.articles.length}');

      await localDatasource.questionsToCache(questions);

      return questions;
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
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final newsByCategory = NewsModel.fromJson(response.data!);

      await localDatasource.newsByCategoryToCache(newsByCategory, category);

      return newsByCategory;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<ArticleModel> getSingleNews(String id) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/news/1.0?id=$id';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final singleNews = ArticleModel.fromJson(
        response.data!['response'] as Map<String, dynamic>,
      );

      await localDatasource.singleNewsToCache(singleNews);

      return singleNews;
    } on ServerException {
      throw ServerFailure();
    }
  }

  @override
  Future<ArticleModel> getSingleQuestion(String id) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/faq/1.0?id=$id';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      final singleQuestion = ArticleModel.fromJson(
        response.data!['response'] as Map<String, dynamic>,
      );

      await localDatasource.singleQuestionToCache(singleQuestion);

      return singleQuestion;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
