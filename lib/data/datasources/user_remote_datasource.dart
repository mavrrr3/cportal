import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<UserModel> logIn(String connectongCode);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> logIn(String connectongCode) async {
    try {
      return UserModel(
        id: 'id',
        userName: 'userName',
        profileId: 'profileId',
        lastLogin: DateTime.parse('2022-03-21T14:59:58.884Z'),
        blocked: false,
        dateCreated: DateTime.parse('2022-03-21T14:59:58.884Z'),
        userCreated: 'userCreated',
        dateUpdated: DateTime.parse('2022-03-21T14:59:58.884Z'),
        userUpdated: 'userUpdated',
        userType: UserTypeModel(id: '1', code: 'ddd', description: 'ddd'),
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
