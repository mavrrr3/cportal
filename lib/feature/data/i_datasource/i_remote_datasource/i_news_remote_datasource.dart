import 'package:cportal_flutter/feature/data/models/news_model.dart';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNewsByCategory(int page, String category);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchQuestions(int page);

  /// Обращается к эндпойнту .....
  /// Возвращает [NewsModel]
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchQuestionsByCategory(int page, String category);
}
