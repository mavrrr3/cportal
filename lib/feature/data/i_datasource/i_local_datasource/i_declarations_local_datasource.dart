import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_model.dart';

abstract class IDeclarationsLocalDataSource {
  /// Извлекаем [List<DeclarationModel>] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<List<DeclarationModel>> fetchDeclarationsFromCache(int page);

  /// Сохраняем [List<DeclarationModel>] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> declarationsToCache(List<DeclarationModel> declarations, int page);
}
