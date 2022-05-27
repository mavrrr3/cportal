import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

class ProfileLocalDataSource implements IProfileLocalDataSource {
  @override
  Future<void> singleProfileToCache(ProfileModel profile) async {
    // ignore: format-comment
    // Await Hive.deleteBoxFromDisk('single_profile');
    log(profile.toString());
    final box = await Hive.openBox<ProfileModel>('single_profile');

    await box.put(profile.id, profile);
  }

  @override
  Future<ProfileModel?> getSingleProfileFromCache(String id) async {
    final box = await Hive.openBox<ProfileModel>('single_profile');
    final profile = box.get(id);
    if (kDebugMode) log('Из кэша $profile');

    return profile;
  }
}
