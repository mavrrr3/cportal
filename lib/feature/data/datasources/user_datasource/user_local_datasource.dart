import 'dart:developer';
import 'package:cportal_flutter/feature/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

class UserLocalDataSource implements IUserLocalDataSource {
  @override
  Future<void> currentUserToCache(UserModel user) async {
    // await Hive.deleteBoxFromDisk('single_user');
    if (kDebugMode) log('UserModel сохранил в кэш $user');

    final box = await Hive.openBox<UserModel>('single_user');

    await box.put('current_user', user);

    await Hive.box<UserModel>('single_user').close();
  }

  @override
  Future<UserModel?> getCurrentUserFromCache() async {
    final box = await Hive.openBox<UserModel>('single_user');
    final user = box.get('current_user');
    if (kDebugMode) log('UserModel Из кэша $user');

    await Hive.box<UserModel>('single_user').close();

    return user;
  }
}
