import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_declarations_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/documents/declarations/declaration_card_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class DeclarationsLocalDataSource implements IDeclarationsLocalDataSource {
  final HiveInterface hive;

  DeclarationsLocalDataSource(this.hive);

  @override
  Future<List<DeclarationCardModel>> fetchDeclarationsFromCache(
    int page,
  ) async {
    var box = await Hive.openBox<List<DeclarationCardModel>>('declarations');

    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationCardModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationCardModel>>('declarations');
    }

    final declarations = box.get('declarations_page_$page');

    if (kDebugMode) {
      log('List<DeclarationModel> [page $page] из кэша $declarations');
    }

    await Hive.box<List<DeclarationCardModel>>('declarations').close();

    return declarations!;
  }

  @override
  Future<void> declarationsToCache(
    List<DeclarationCardModel> declarations,
    int page,
  ) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('declarations');
    var box = await Hive.openBox<List<DeclarationCardModel>>('declarations');
    if (!Hive.isBoxOpen('declarations')) {
      await Hive.openBox<List<DeclarationCardModel>>('declarations');
    } else {
      box = await Hive.openBox<List<DeclarationCardModel>>('declarations');
    }
    log('List<DeclarationModel> [page $page] сохранил в кэш ${declarations.length} заявлений');

    await box.put('declarations_page_$page', declarations);

    await Hive.box<List<DeclarationCardModel>>('declarations').close();
  }
}
