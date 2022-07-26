import 'package:cportal_flutter/feature/data/models/article_model.dart';
import 'package:cportal_flutter/feature/data/models/news_model.dart';

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

  /// Сохраняет [ArticleModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> singleQuestionToCache(ArticleModel question);

  /// Извлекает [ArticleModel] из кеша
  /// Возвращает [ArticleModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<ArticleModel> getSingleQuestionFromCache(String id);

  /// Сохраняет [ArticleModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> singleNewsToCache(ArticleModel singleNews);

  /// Извлекает [ArticleModel] из кеша
  /// Возвращает [ArticleModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<ArticleModel> getSingleNewsFromCache(String id);
}
