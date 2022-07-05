import 'package:cportal_flutter/feature/data/models/user/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel?> logInWithConnectingCode({required String connectingCode});

  Future<UserModel?> getUser();

  Future<bool> isAuthenticated();
}
