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

  /// Извлекает [NewsModel] из кеша
  /// Возвращает [NewsModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<NewsModel> fetchQuestionsFromCache();

  /// Сохраняет [NewsModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> questionsToCache(NewsModel news);
}

class NewsLocalDataSource implements INewsLocalDataSource {
  final HiveInterface hive;

  NewsLocalDataSource(this.hive);

  @override
  Future<NewsModel> fetchNewsFromCache() async {
    var box = await Hive.openBox<NewsModel>('news');
    log(Hive.isBoxOpen('news').toString());
    if (!Hive.isBoxOpen('news')) {
      await Hive.openBox<NewsModel>('news');
    } else {
      box = await Hive.openBox<NewsModel>('news');
    }

    final news = box.get('news');

    if (kDebugMode) log('NewsModel из кэша ${news!.response.count}');

    await Hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsToCache(NewsModel news) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('news');
    var box = await Hive.openBox<NewsModel>('news');
    if (!Hive.isBoxOpen('news')) {
      await Hive.openBox<NewsModel>('news');
    } else {
      box = await Hive.openBox<NewsModel>('news');
    }
    log('NewsModel сохранил в кэш ${news.response.count}');

    await box.put('news', news);

    await Hive.box<NewsModel>('news').close();
  }

  @override
  Future<NewsModel> fetchNewsByCategoryFromCache(String category) async {
    var box = await hive.openBox<NewsModel>('news');
    if (!Hive.isBoxOpen('news')) {
      await Hive.openBox<NewsModel>('news');
    } else {
      box = await Hive.openBox<NewsModel>('news');
    }
    final news = box.get(category);

    if (news != null) {
      log('NewsModel by $category из кэша ${news.response.count}');
    }

    await Hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsByCategoryToCache(NewsModel news, String category) async {
    var box = await hive.openBox<NewsModel>('news');
    if (!Hive.isBoxOpen('news')) {
      await Hive.openBox<NewsModel>('news');
    } else {
      box = await Hive.openBox<NewsModel>('news');
    }

    log('NewsModel by $category сохранил в кэш ${news.response.count} статей');
    await box.put(category, news);

    await Hive.box<NewsModel>('news').close();
  }

  @override
  Future<NewsModel> fetchQuestionsFromCache() async {
    var box = await Hive.openBox<NewsModel>('questions');
    log(Hive.isBoxOpen('questions').toString());
    if (!Hive.isBoxOpen('questions')) {
      await Hive.openBox<NewsModel>('questions');
    } else {
      box = await Hive.openBox<NewsModel>('questions');
    }

    final questions = box.get('questions');

    if (kDebugMode) log('questions из кэша ${questions!.response.count}');

    await Hive.box<NewsModel>('questions').close();

    return questions!;
  }

  @override
  Future<void> questionsToCache(NewsModel questions) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('questions');
    var box = await Hive.openBox<NewsModel>('questions');
    if (!Hive.isBoxOpen('questions')) {
      await Hive.openBox<NewsModel>('questions');
    } else {
      box = await Hive.openBox<NewsModel>('questions');
    }
    log('questions сохранил в кэш ${questions.response.count}');

    await box.put('questions', questions);

    await Hive.box<NewsModel>('questions').close();
  }
}
