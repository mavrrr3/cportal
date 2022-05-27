import 'dart:developer';

import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class INewsLocalDataSource {
  /// Извлекаем [NewsModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<NewsModel> fetchNewsFromCache();

  /// Сохраняем [NewsModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> newsToCache(NewsModel news);
}

class NewsLocalDataSource implements INewsLocalDataSource {
  final HiveInterface hive;

  NewsLocalDataSource(this.hive);

  @override
  Future<NewsModel> fetchNewsFromCache() async {
    final box = await hive.openBox<NewsModel>('news');

    final news = box.get('news');

    if (kDebugMode) log('NewsModel из кэша $news');

    await Hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsToCache(NewsModel news) async {
    // Удаляет box с диска
    // await Hive.deleteBoxFromDisk('news');

    if (kDebugMode) log('NewsModel сохранил в кэш $news');

    final box = await hive.openBox<NewsModel>('news');

    await box.put('news', news);

    await Hive.box<NewsModel>('news').close();
  }
}
