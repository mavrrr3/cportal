import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/login/login_params.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<UserModel> login({required LogInParams loginParams}) async {
    final queryParameters = <String, dynamic>{
      'binding_code': loginParams.connectingCode,
      'device': Uri.encodeComponent(loginParams.device),
      'app': Uri.encodeComponent(loginParams.deviceDescription),
      'platform': loginParams.platform.name,
      'location': Uri.encodeComponent(loginParams.location ?? ''),
    };
    final result = await _makeRequest(queryParameters: queryParameters, method: 'GET');

    return ResponseUserModel.fromJson(result.data!).response;
  }

  Future<Response<Map<String, dynamic>>> _makeRequest({
    required Map<String, dynamic> queryParameters,
    required String method,
  }) async {
    return _dio.fetch<Map<String, dynamic>>(
      Options(method: method, responseType: ResponseType.json)
          .compose(
            _dio.options,
            '/cportal/hs/api/secure/1.0',
            queryParameters: queryParameters,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    );
  }
}
