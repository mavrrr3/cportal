import 'package:cportal_flutter/core/error/exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:cportal_flutter/feature/data/datasources/user_datasource/user_local_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user_model.dart';

abstract class IUserRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<UserModel> login(String connectongCode);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final IUserLocalDataSource localDatasource;

  UserRemoteDataSource(this.localDatasource);

  @override
  Future<UserModel> login(String connectongCode) async {
    try {
      final remoteUser = UserModel(
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
      // log(remoteUser.toString());
      await localDatasource.singleUserToCache(remoteUser);

      return remoteUser;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
