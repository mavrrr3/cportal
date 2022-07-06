import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<ResponseUserModel> login(String connectingCode, String device);

  Future<ResponseUserModel> getUser(String token);
}
