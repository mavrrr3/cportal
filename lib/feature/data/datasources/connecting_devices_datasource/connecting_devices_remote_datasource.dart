import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_response.dart';
import 'package:dio/dio.dart';

class ConnectingDevicesRemoteDataSource extends IConnectingDevicesRemoteDataSource {
  final Dio _dio;

  ConnectingDevicesRemoteDataSource(this._dio);

  @override
  Future<ConnectingDevicesModel> getConnectingDevices({required String token}) async {
    final queryParameters = <String, dynamic>{'token': token};
    final result = await _makeRequest(method: 'GET', queryParameters: queryParameters);

    return ConnectingDevicesResponse.fromJson(result.data!).response;
  }

  @override
  Future<void> endOtherSessions({required String token}) async {
    final queryParameters = <String, dynamic>{'token': token};
    await _makeRequest(method: 'DELETE', queryParameters: queryParameters);
  }

  Future<Response<Map<String, dynamic>>> _makeRequest({
    required Map<String, dynamic> queryParameters,
    required String method,
  }) async {
    return _dio.fetch<Map<String, dynamic>>(
      Options(method: method, responseType: ResponseType.json)
          .compose(
            _dio.options,
            '/cportal/hs/api/secure/devices/1.0',
            queryParameters: queryParameters,
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    );
  }
}
