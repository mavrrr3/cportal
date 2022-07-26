import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_location_remote_datasource.dart';
import 'package:cportal_flutter/feature/data/models/location/location.dart';
import 'package:dio/dio.dart';

class LocationRemoteDataSource implements ILocationRemoteDataSource {
  final Dio _dio;

  LocationRemoteDataSource(this._dio);

  @override
  Future<Location?> getLocation() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('http://ip-api.com/json');

      return Location.fromJson(response.data!);
    } on Exception catch (_) {
      return null;
    }
  }
}
