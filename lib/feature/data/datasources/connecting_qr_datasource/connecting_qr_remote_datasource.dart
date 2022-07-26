import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_qr_remote_datasource.dart';
import 'package:dio/dio.dart';

class ConnectingQrRemoteDataSource implements IConnectingQrRemoteDataSource {
  final Dio _dio;

  ConnectingQrRemoteDataSource(this._dio);

  @override
  Future<void> sendConnectingData({required String connectingCode}) {
    final queryParameters = <String, dynamic>{'binding_code': connectingCode};

    return _makeRequest(queryParameters: queryParameters);
  }

  @override
  Future<void> sendScannedData({required String connectingCode}) {
    final queryParameters = <String, dynamic>{'binding_code': connectingCode};

    return _makeRequest(queryParameters: queryParameters);
  }

  Future<Response<Map<String, dynamic>>> _makeRequest({
    required Map<String, dynamic> queryParameters,
  }) async {
    return _dio.fetch<Map<String, dynamic>>(
      Options(method: 'POST', responseType: ResponseType.json)
          .compose(
            _dio.options,
            '/cportal/hs/api/secure/1.0',
            queryParameters: queryParameters,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    );
  }
}
