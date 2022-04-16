import 'package:cportal_flutter/feature/data/models/news_model.dart';

abstract class INewsRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем ошибки через [ServerException]
  Future<NewsModel> fetchNews();
}
