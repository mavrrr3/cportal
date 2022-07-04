import 'package:cportal_flutter/feature/data/api/auth_api.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';

class AuthRepository implements IAuthRepository {
  final AuthApi _authApi;
  final HiveInterface _hive;

  AuthRepository(this._authApi, this._hive);

  @override
  Future<UserModel?> getUser() async {
    final localUser = await _getCachedUser();

    if (localUser == null) return null;

    try {
      final responseUserModel = await _authApi.getUser(localUser.token);
      final user = responseUserModel.response;
      await _saveUser(user);

      return user;
    } on Exception catch (_) {
      return localUser;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final localUser = await _getCachedUser();

    return localUser != null;
  }

  @override
  Future<UserModel?> logInWithConnectingCode({required String connectingCode}) async {
    try {
      final info = await DeviceInfoPlugin().deviceInfo;
      final deviceName = info.toMap()['name'] as String;

      final responseUserModel = await _authApi.login(connectingCode, deviceName);
      final user = responseUserModel.response;
      await _saveUser(user);

      return user;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> _saveUser(UserModel user) async {
    final box = await _hive.openBox<UserModel>('user');
    await box.put('user', user);
  }

  Future<UserModel?> _getCachedUser() async {
    final box = await _hive.openBox<UserModel>('user');

    return box.get('user');
  }
}
