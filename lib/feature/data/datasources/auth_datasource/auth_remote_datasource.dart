import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_auth_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:cportal_flutter/feature/domain/entities/device_info.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<ResponseUserModel> getUser(String token) async {
    final queryParameters = <String, dynamic>{'token': token};
    final result = await _makeRequest(queryParameters: queryParameters, method: 'GET');

    return ResponseUserModel.fromJson(result.data!);
  }

  @override
  Future<ResponseUserModel> login(String connectingCode, DeviceInfo deviceInfo) async {
    final queryParameters = <String, dynamic>{'binding_code': connectingCode, 'device': deviceInfo.name};
    final result = await _makeRequest(queryParameters: queryParameters, method: 'GET');

    return ResponseUserModel.fromJson(result.data!);
  }

  @override
  Future<void> sendConnectingData({required String qrData}) {
    final queryParameters = <String, dynamic>{'binding_code': qrData};

    return _makeRequest(queryParameters: queryParameters, method: 'POST');
  }

  @override
  Future<void> sendScannedData({required String qrData, required String token}) {
    final queryParameters = <String, dynamic>{'binding_code': qrData, 'token': token};

    return _makeRequest(queryParameters: queryParameters, method: 'POST');
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
