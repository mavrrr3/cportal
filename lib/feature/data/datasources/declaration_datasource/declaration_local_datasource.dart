import 'dart:developer';

import 'package:cportal_flutter/feature/data/models/declarations/declaration_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class IDeclarationLocalDataSource {
  /// Возвращает [List<DeclarationModel>] из кеша постранично
  ///
  /// Пробрасываем все ошибки через [CacheException]
  Future<List<DeclarationModel>> fetchDeclarationsFromCache(int page);

  /// Сохраняет [List<DeclarationModel>] в кэш
  ///
  /// Пробрасывает все ошибки через [CacheException]
  Future<void> declarationsToCache(
    List<DeclarationModel> declarations,
    int page,
  );
}

class DeclarationLocalDataSource implements IDeclarationLocalDataSource {
  final HiveInterface hive;

  DeclarationLocalDataSource(this.hive);

  @override
  Future<List<DeclarationModel>> fetchDeclarationsFromCache(int page) async {
    var box = await Hive.openBox<List<DeclarationModel>>('declarations');

    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationModel>>('declarations');
    }

    final declarations = box.get('declarations_page_$page');

    if (kDebugMode) log('List<DeclarationModel> из кэша $declarations');

    await Hive.box<List<DeclarationModel>>('declarations').close();

    return declarations!;
  }

  @override
  Future<void> declarationsToCache(
    List<DeclarationModel> declarations,
    int page,
  ) async {
    // Удаляет box с диска
    // await Hive.deleteBoxFromDisk('news');
    var box = await Hive.openBox<List<DeclarationModel>>('declarations');
    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationModel>>('declarations');
    }
    log('List<DeclarationModel> сохранил в кэш $declarations');

    await box.put('declarations_page_$page', declarations);

    await Hive.box<List<DeclarationModel>>('news').close();
  }
}
