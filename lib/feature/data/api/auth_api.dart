import 'package:cportal_flutter/feature/data/models/user/response_user_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @GET('/cportal/hs/api/secure/1.0')
  Future<ResponseUserModel> login(
    @Query('binding_code') String connectingCode,
    @Query('device') String device,
  );

  @GET('/cportal/hs/api/secure/1.0')
  Future<ResponseUserModel> getUser(@Query('token') String token);
}
