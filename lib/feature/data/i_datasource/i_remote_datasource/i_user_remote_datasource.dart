import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<UserModel> getUser();
}
