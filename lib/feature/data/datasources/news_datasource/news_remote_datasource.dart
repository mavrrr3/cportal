import 'dart:convert';
import 'dart:developer';
import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_news_remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;
  final Dio dio;

  NewsRemoteDataSource(this.localDatasource, this.dio);

  @override
  Future<NewsModel> fetchNews(int page) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page';

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
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page&category=$category';

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
  Future<NewsModel> fetchQuastions(int page) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/faq/1.0/?page=$page';

    try {
      final response = await dio.get<String>(baseUrl);

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
  Future<NewsModel> fetchQuastionsByCategory(int page, String category) async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/news/1.0/?page=$page&category=$category';
    log('baseUrl $baseUrl');

    try {
      final response = await dio.get<String>(baseUrl);

      final newsByCategory = NewsModel.fromJson(
        json.decode(response.data!) as Map<String, dynamic>,
      );

      await localDatasource.newsByCategoryToCache(newsByCategory, category);
      log(newsByCategory.toString());

      return newsByCategory;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
