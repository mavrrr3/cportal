import 'package:cportal_flutter/feature/data/i_datasource/i_local_datasource/i_user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:hive/hive.dart';

class UserLocalDataSource implements IUserLocalDataSource {
  final HiveInterface _hive;

  UserLocalDataSource(this._hive);

  @override
  Future<UserModel?> getUser() async {
    final box = await _hive.openBox<UserModel>('user');

    return box.get('user');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final box = await _hive.openBox<UserModel>('user');

    await box.put('user', user);
  }
}
