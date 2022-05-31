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
final String _baseUrl = '${AppConfig.apiUri}/cportal/hs/api/news/1.0';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews(String code);
}

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;

  NewsRemoteDataSource(this.localDatasource);

  @override
  Future<NewsModel> fetchNews(String code) async {
    try {
      final response = await _ioClient.get(Uri.parse(_baseUrl), headers: {
        'Content-Type': 'application/json',
      });

      return NewsModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } on ServerException {
      throw ServerFailure();
    }
  }
}
