import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<ResponseUserModel> getUser(String token) async {
    final queryParameters = <String, dynamic>{'token': token};

    return _makeRequest(queryParameters);
  }

  @override
  Future<ResponseUserModel> login(String connectingCode, String device) async {
    final queryParameters = <String, dynamic>{'binding_code': connectingCode, 'device': device};

    return _makeRequest(queryParameters);
  }

  Future<ResponseUserModel> _makeRequest(Map<String, dynamic> queryParameters) async {
    final result = await _dio.fetch<Map<String, dynamic>>(
      Options(method: 'GET', responseType: ResponseType.json)
          .compose(
            _dio.options,
            '/cportal/hs/api/secure/1.0',
            queryParameters: queryParameters,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    );

    return ResponseUserModel.fromJson(result.data!);
  }
}
