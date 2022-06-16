import 'dart:developer';
import 'package:cportal_flutter/feature/data/models/onboarding_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class IOnboardingLocalDataSource {
  /// Извлекает [OnboardingModel] из кеша
  /// Возвращает [OnboardingModel]
  /// Пробрасываем все ошибки через [CacheException]
  Future<OnboardingModel> fetchOnboardingFromCache();

  /// Сохраняет [OnboardingModel] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> onboardingToCache(OnboardingModel onboarding);
}

class OnboardingLocalDataSource implements IOnboardingLocalDataSource {
  final HiveInterface hive;

  OnboardingLocalDataSource(this.hive);

  @override
  Future<OnboardingModel> fetchOnboardingFromCache() async {
    var box = await Hive.openBox<OnboardingModel>('onboarding');
    log(Hive.isBoxOpen('onboarding').toString());
    if (!Hive.isBoxOpen('onboarding')) {
      await Hive.openBox<OnboardingModel>('onboarding');
    } else {
      box = await Hive.openBox<OnboardingModel>('onboarding');
    }

    final onboarding = box.get('onboarding');

    if (kDebugMode) log('OnboardingModel из кэша $onboarding');

    await Hive.box<OnboardingModel>('onboarding').close();

    return onboarding!;
  }

  @override
  Future<void> onboardingToCache(OnboardingModel onboarding) async {
    // Удаляет box с диска
    // await Hive.deleteBoxFromDisk('news');
    var box = await Hive.openBox<OnboardingModel>('onboarding');
    if (!Hive.isBoxOpen('onboarding')) {
      await Hive.openBox<OnboardingModel>('onboarding');
    } else {
      box = await Hive.openBox<OnboardingModel>('onboarding');
    }
    log('OnboardingModel сохранил в кэш $onboarding');

    await box.put('onboarding', onboarding);

    await Hive.box<OnboardingModel>('onboarding').close();
  }
}
