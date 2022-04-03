import 'dart:convert';

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
    String stringUser = '''
                          {
                            "id": "983636252",
                            "user_name": "login",
                            "profile_id": "2828287272",
                            "last_login": "2022-03-21T14:59:58.884Z",
                            "blocked": false,
                            "date_created": "2022-03-21T14:59:58.884Z",
                            "user_created": "838383",
                            "date_updaetd": null,
                            "user_updated": "",
                            "user_type": {
                              "id": "01",
                              "code": "A",
                              "description": "Администратор"
                            }}''';
    var jsonUser = json.decode(stringUser);
    UserModel localeUser = UserModel.fromJson(jsonUser);

    return localeUser;
  }

  @override
  Future<List<UserModel>> searchUsers(String query) {
    // TODO: implement searchUsers
    throw UnimplementedError();
  }
}
