import 'package:cportal_flutter/feature/data/models/news_model.dart';

abstract class INewsLocalDataSource {
  /// Извлекаем [NewsModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<NewsModel> fetchNewsFromCache();
}
