import 'package:cportal_flutter/feature/data/models/main_search_model.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';

abstract class IMainSearchLocalDataSource {
  /// Сохраняем локально [MainSearchModel]
  /// Пробрасываем ошибки через [CacheException]
  Future<void> addMainSearchToMemory(MainSearchEntity mainsearch);

  /// Извлекаем из кеша [List<MainSearchModel>]
  /// Пробрасываем ошибки через [CacheException]
  Future<List<MainSearchModel>?> getMainSearchFromMemory();
}
