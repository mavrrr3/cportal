import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource implements IUserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  @override
  Future<UserModel> getUser() async {
    final result =
        await _dio.get<Map<String, dynamic>>('/cportal/hs/api/secure/1.0');

    return ResponseUserModel.fromJson(result.data!).response;
  }
}
