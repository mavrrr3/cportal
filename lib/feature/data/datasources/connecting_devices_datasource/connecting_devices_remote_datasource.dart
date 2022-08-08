import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_connecting_devices_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_model.dart';
import 'package:cportal_flutter/feature/data/models/connecting_devices/connecting_devices_response.dart';
import 'package:dio/dio.dart';

class ConnectingDevicesRemoteDataSource extends IConnectingDevicesRemoteDataSource {
  final Dio _dio;

  ConnectingDevicesRemoteDataSource(this._dio);

  @override
  Future<ConnectingDevicesModel> getConnectingDevices() async {
    final result = await _makeRequest(method: 'GET');

    return ConnectingDevicesResponse.fromJson(result.data!).response;
  }

  @override
  Future<void> endOtherSessions() async {
    await _makeRequest(method: 'DELETE');
  }

  Future<Response<Map<String, dynamic>>> _makeRequest({
    required String method,
  }) async {
    return _dio.fetch<Map<String, dynamic>>(
      Options(method: method, responseType: ResponseType.json)
          .compose(
            _dio.options,
            '/cportal/hs/api/secure/devices/1.0',
          )
          .copyWith(baseUrl: _dio.options.baseUrl),
    );
  }
}
