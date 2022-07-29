import 'dart:developer';

import 'package:cportal_flutter/common/util/force_open_box.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_main_search_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/main_search_model.dart';
import 'package:cportal_flutter/feature/domain/entities/main_search_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainSearchLocalDatasource implements IMainSearchLocalDataSource {
  final HiveInterface _hive;

  MainSearchLocalDatasource(this._hive);

  @override
  Future<void> addMainSearchToMemory(MainSearchEntity mainsearch) async {
    // Удаляет box с диска.
    // await Hive.deleteBoxFromDisk('mainsearch');
    final box = await forceOpenBox<List<MainSearchEntity>>('mainsearch');
    log('MainSearchEntity сохранил в кэш $mainsearch');

    List<MainSearchEntity> listMainSearch = [];
    final listMainSearch2 = box.get('mainsearch');

    if (listMainSearch2 != null) listMainSearch = listMainSearch2;
    if (listMainSearch.length == 4) listMainSearch.removeAt(0);
    listMainSearch.add(mainsearch);

    log('List<MainSearchModel> сейчас в кэше $listMainSearch');

    await box.put('mainsearch', listMainSearch);

    await _hive.box<List<MainSearchEntity>>('mainsearch').close();
  }

  @override
  Future<List<MainSearchModel>?> getMainSearchFromMemory() async {
    final box = await forceOpenBox<List<MainSearchModel>>('mainsearch');

    final listMainSearch = box.get('mainsearch');

    log('List<MainSearchModel> извлёк из кэша $listMainSearch');

    await _hive.box<List<MainSearchModel>>('mainsearch').close();

    return listMainSearch;
  }
}
