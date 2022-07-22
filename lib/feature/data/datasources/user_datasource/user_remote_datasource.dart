import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_user_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDataSource implements IUserRemoteDataSource {
  final Dio _dio;

  UserRemoteDataSource(this._dio);

  @override
  Future<UserModel> getUser({required String token}) async {
    final queryParameters = <String, dynamic>{'token': token};
    final result = await _dio.get<Map<String, dynamic>>('/cportal/hs/api/secure/1.0', queryParameters: queryParameters);

    return ResponseUserModel.fromJson(result.data!).response;
  }
}
