import 'package:cportal_flutter/feature/data/models/profile_model.dart';

abstract class IProfileLocalDataSource {
  /// Сохраняем [ProfileModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> singleProfileToCache(ProfileModel profile);

  /// Извлекаем [ProfileModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<ProfileModel?> getSingleProfileFromCache(String id);
}
