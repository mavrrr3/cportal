import 'package:cportal_flutter/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<UserModel> getSingleUser(String id);

  /// Обращается к эндпойнту .....
  ///
  /// Пробрасываем все ошибки через [ServerException]
  Future<List<UserModel>> searchUsers(String query);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> getSingleUser(String id) async {
    return const UserModel(
      id: 'id',
      username: 'Василий Алибабаевич Мирошниченко',
      position: 'Главный бухгалтер',
      image:
          'https://demotivation.ru/wp-content/uploads/2021/01/scale_1200-1-768x403.jpg',
      department: 'Бухгалтерия',
      email: 'email@mail.ru',
      internalPhone: '45678',
      externalPhone: '+79094450353',
    );
  }

  @override
  Future<List<UserModel>> searchUsers(String query) {
    // TODO: implement searchUsers
    throw UnimplementedError();
  }
}
