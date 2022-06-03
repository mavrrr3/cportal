import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class INewsLocalDataSource {
  /// Извлекает [NewsModel] из кеша
  /// Возвращает [NewsModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<NewsModel> fetchNewsFromCache();

  /// Сохраняет [NewsModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> newsToCache(NewsModel news);

  /// Извлекает [NewsModel] из кеша
  /// Возвращает [NewsModel]
  /// Пробрасывает все ошибки через [CacheException]
  Future<NewsModel> fetchNewsByCategoryFromCache(String category);

  /// Сохраняет [NewsModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> newsByCategoryToCache(NewsModel news, String category);
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

  @override
  Future<NewsModel> fetchNewsByCategoryFromCache(String category) async {
    final box = await hive.openBox<NewsModel>('news');

    final news = box.get(category);

    if (kDebugMode) log('NewsModel by $category из кэша $news');

    await Hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsByCategoryToCache(NewsModel news, String category) async {
    if (kDebugMode) log('NewsModel by $category сохранил в кэш $news');

    final box = await hive.openBox<NewsModel>('news');

    await box.put(category, news);

    await Hive.box<NewsModel>('news').close();
  }
}
