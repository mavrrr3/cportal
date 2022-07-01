import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';

abstract class IAuthRepository {
  Future<UserEntity> logInWithConnectingCode({required String connectingCode});

  Future<UserEntity> getUser();

  Future<bool> isAuthenticated();
}
