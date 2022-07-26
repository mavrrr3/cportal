import 'package:cportal_flutter/feature/data/models/login/login_params.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<UserModel> login({required LogInParams loginParams});
}
