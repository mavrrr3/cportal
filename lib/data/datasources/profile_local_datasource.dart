import 'dart:developer';

import 'package:cportal_flutter/data/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ProfileLocalDataSource {
  /// Сохраняем [ProfileModel] в кэш
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<void> singleProfileToCache(ProfileModel profile);

  /// Извлекаем [ProfileModel] из кеша
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<ProfileModel?> getSingleProfileFromCache(String id);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<void> singleProfileToCache(ProfileModel profile) async {
    // await Hive.deleteBoxFromDisk('single_profile');

    var box = await Hive.openBox('single_profile');

    await box.put(profile.id, profile);
  }

  @override
  Future<ProfileModel?> getSingleProfileFromCache(String id) async {
    var box = await Hive.openBox<ProfileModel>('single_profile');
    var profile = box.get(id);
    if (kDebugMode) log('Из кэша ' + profile.toString());

    return profile;
  }
}
