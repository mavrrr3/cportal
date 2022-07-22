import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IUserLocalDataSource {
  Future<UserModel?> getUser();

  Future<void> saveUser(UserModel user);
}
