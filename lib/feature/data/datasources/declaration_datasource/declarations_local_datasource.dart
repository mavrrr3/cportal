import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/declarations/declaration_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DeclarationsLocalDataSource implements IDeclarationsLocalDataSource {
  final HiveInterface hive;

  DeclarationsLocalDataSource(this.hive);

  @override
  Future<List<DeclarationModel>> fetchDeclarationsFromCache(int page) async {
    var box = await Hive.openBox<List<DeclarationModel>>('declarations');

    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationModel>>('declarations');
    }

    final declarations = box.get('declarations_page_$page');

    if (kDebugMode) log('List<DeclarationModel> [page $page] из кэша $declarations');

    await Hive.box<List<DeclarationModel>>('declarations').close();

    return declarations!;
  }

  @override
  Future<void> declarationsToCache(List<DeclarationModel> declarations, int page) async {
    // Удаляет box с диска.
    await Hive.deleteBoxFromDisk('declarations');
    var box = await Hive.openBox<List<DeclarationModel>>('declarations');
    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationModel>>('declarations');
    }
    log('List<DeclarationModel> [page $page] сохранил в кэш $declarations');

    await box.put('declarations_page_$page', declarations);

    await Hive.box<List<DeclarationModel>>('declarations').close();
  }
}
