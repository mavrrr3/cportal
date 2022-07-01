import 'package:cportal_flutter/feature/domain/entities/user/user_entity.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  @override
  Future<UserEntity> getUser() {
    return Future.value(user);
  }

  @override
  Future<bool> isAuthenticated() => Future.value(true);

  @override
  Future<UserEntity> logInWithConnectingCode({required String connectingCode}) {
    return Future.value(user);
  }
}

// TODO mock data
// delete this
final user = UserEntity(
  id: '1',
  name: 'name',
  department: 'department',
  position: 'position',
  birthDate: DateTime.now(),
  contacts: const [],
  photoUrl: 'photoUrl',
);
