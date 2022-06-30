import 'package:cportal_flutter/feature/data/models/user_model.dart';

abstract class IUserLocalDataSource {
  /// Сохраняем [UserModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> currentUserToCache(UserModel user);

  /// Извлекаем [UserModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<UserModel?> getCurrentUserFromCache();
}
