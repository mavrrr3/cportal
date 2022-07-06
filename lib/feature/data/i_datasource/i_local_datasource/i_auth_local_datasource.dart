import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveUser(UserModel user);

  Future<UserModel?> getCachedUser();

  Future<String> getDeviceName();
}
