import 'dart:developer';

import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_profile_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileLocalDataSource implements IProfileLocalDataSource {
  @override
  Future<void> singleProfileToCache(ProfileModel profile) async {
    var box = await Hive.openBox<ProfileModel>('single_profile');
  if (!Hive.isBoxOpen('single_profile')) {
      await Hive.openBox<ProfileModel>('single_profile');
    } else {
      box = await Hive.openBox<ProfileModel>('single_profile');
    }

    log('ProfileModel сохранил в кэш $profile');

    await box.put('single_profile', profile);

    await Hive.box<ProfileModel>('single_profile').close();
  }

  @override
  Future<ProfileModel?> getSingleProfileFromCache(String id) async {
    final box = await Hive.openBox<ProfileModel>('single_profile');
    final profile = box.get(id);
    if (kDebugMode) log('Из кэша $profile');

    return profile;
  }
}
