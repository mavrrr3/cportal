import 'dart:convert';
import 'dart:io';
import 'package:cportal_flutter/app_config.dart';
import 'package:http/io_client.dart';

import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

const bool trustSelfSigned = true;
final HttpClient _httpClient = HttpClient()
  ..badCertificateCallback = ((cert, host, port) => trustSelfSigned);
final IOClient _ioClient = IOClient(_httpClient);

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNewsByCategory(int page, String category);
}

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;

  NewsRemoteDataSource(this.localDatasource);

  @override
  Future<NewsModel> fetchNews(int page) async {
    final String baseUrl =
        '${AppConfig.apiUri}/cportal/hs/api/news/1.1/?page=$page';

    try {
      final response = await _ioClient.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
      });
      final news = NewsModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
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
        '${AppConfig.apiUri}/cportal/hs/api/news/1.1/?page=$page&category=$category';

    try {
      final response = await _ioClient.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
      });
      final newsByCategory = NewsModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );

      await localDatasource.newsByCategoryToCache(newsByCategory, category);

      return newsByCategory;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
