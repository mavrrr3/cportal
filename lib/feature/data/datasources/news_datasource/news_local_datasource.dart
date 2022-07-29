import 'dart:developer';

import 'package:cportal_flutter/common/util/force_open_box.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_news_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class NewsLocalDataSource implements INewsLocalDataSource {
  final HiveInterface _hive;

  NewsLocalDataSource(this._hive);

  @override
  Future<NewsModel> fetchNewsFromCache() async {
    final box = await forceOpenBox<NewsModel>('news');

    final news = box.get('news');

    if (kDebugMode) log('NewsModel из кэша ${news!.response.count}');

    await _hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsToCache(NewsModel news) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('news');
    final box = await forceOpenBox<NewsModel>('news');
    log('NewsModel сохранил в кэш ${news.response.count}');

    await box.put('news', news);

    await _hive.box<NewsModel>('news').close();
  }

  @override
  Future<NewsModel> fetchNewsByCategoryFromCache(String category) async {
    final box = await forceOpenBox<NewsModel>('news');

    final news = box.get(category);

    if (news != null) {
      log('NewsModel by $category из кэша ${news.response.count}');
    }

    await _hive.box<NewsModel>('news').close();

    return news!;
  }

  @override
  Future<void> newsByCategoryToCache(NewsModel news, String category) async {
    final box = await forceOpenBox<NewsModel>('news');

    log('NewsModel by $category сохранил в кэш ${news.response.count} статей');
    await box.put(category, news);

    await _hive.box<NewsModel>('news').close();
  }

  @override
  Future<NewsModel> fetchQuestionsFromCache() async {
    final box = await forceOpenBox<NewsModel>('questions');

    final questions = box.get('questions');

    if (kDebugMode) log('questions из кэша ${questions!.response.count}');

    await _hive.box<NewsModel>('questions').close();

    return questions!;
  }

  @override
  Future<void> questionsToCache(NewsModel questions) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('questions');
    final box = await forceOpenBox<NewsModel>('questions');

    log('questions сохранил в кэш ${questions.response.count}');

    await box.put('questions', questions);

    await _hive.box<NewsModel>('questions').close();
  }

  @override
  Future<ArticleModel> getSingleNewsFromCache(String id) async {
    final box = await forceOpenBox<ArticleModel>('singleNews');

    final singleNews = box.get(id);

    if (kDebugMode) log('Single News id=${singleNews!.id} из кэша');

    await _hive.box<NewsModel>('singleNews').close();

    return singleNews!;
  }

  @override
  Future<ArticleModel> getSingleQuestionFromCache(String id) async {
    final box = await forceOpenBox<ArticleModel>('singleQuestion');

    final singleQuestion = box.get(id);

    if (kDebugMode) log('Single Question id=${singleQuestion!.id} из кэша');

    await _hive.box<NewsModel>('singleQuestion').close();

    return singleQuestion!;
  }

  @override
  Future<void> singleNewsToCache(ArticleModel singleNews) async {
    final box = await forceOpenBox<ArticleModel>('singleNews');

    log('ArticleModel with id= ${singleNews.id} сохранил в кэш');
    await box.put(singleNews.id, singleNews);

    await _hive.box<ArticleModel>('singleNews').close();
  }

  @override
  Future<void> singleQuestionToCache(ArticleModel question) async {
    final box = await forceOpenBox<ArticleModel>('singleQuestion');

    log('ArticleModel with id= ${question.id} сохранил в кэш');
    await box.put(question.id, question);

    await _hive.box<ArticleModel>('singleQuestion').close();
  }
}
