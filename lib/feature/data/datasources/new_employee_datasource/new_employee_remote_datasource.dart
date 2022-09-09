import 'package:cportal_flutter/app_config.dart';
import 'package:cportal_flutter/feature/data/i_datasource/i_remote_datasource/i_new_employee_remote_datasource.dart';

import 'package:cportal_flutter/feature/data/models/new_employee_model.dart';
import 'package:cportal_flutter/core/error/server_exception.dart';
import 'package:cportal_flutter/core/error/failure.dart';
import 'package:dio/dio.dart';

class NewEmployeeRemoteDataSource implements INewEmployeeRemoteDataSource {
  final Dio _dio;
  const NewEmployeeRemoteDataSource(this._dio);

  @override
  Future<List<NewEmployeeModel>> fetchNewEmployeeOnboardingSlides() async {
    final String baseUrl = '${AppConfig.apiUri}/cportal/hs/api/slides/1.0/';

    try {
      final response = await _dio.fetch<Map<String, dynamic>>(
        Options(method: 'GET', responseType: ResponseType.json).compose(
          _dio.options,
          baseUrl,
        ),
      );

      return NewEmployeeResponseModel.fromJson(response.data!).slides;
    } on ServerException {
      throw ServerFailure();
    }
  }
}
