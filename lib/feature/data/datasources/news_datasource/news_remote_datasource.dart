import 'dart:developer';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/news_datasource/news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:flutter/foundation.dart';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews();
}

class NewsRemoteDataSource implements INewsRemoteDataSource {
  final INewsLocalDataSource localDatasource;

  NewsRemoteDataSource(this.localDatasource);

  @override
  Future<NewsModel> fetchNews() async {
    try {
      final remoteNews = NewsModel(
        show: true,
        article: [
          ArticleModel(
            id: 'id',
            articleType: const ArticleTypeModel(
              id: 'id',
              code: 'code',
              description: 'description',
            ),
            header: 'header',
            description: 'description',
            image:
                'https://img3.goodfon.ru/original/1152x864/e/2c/wyoming-grand-teton-national.jpg',
            dateShow: DateTime.parse('2022-03-21T14:59:58.884Z'),
            externalLink: 'externalLink',
            show: true,
            userCreated: 'userCreated',
            dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
            userUpdate: 'userUpdate',
            dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
          ),
        ],
      );

      if (kDebugMode) log(remoteNews.toString());

      await localDatasource.newsToCache(remoteNews);

      return remoteNews;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
