import 'package:cportal_flutter/feature/data/models/user/user_model.dart';
import 'package:cportal_flutter/feature/domain/repositories/i_auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class TokenInterceptor extends Interceptor {
  final IAuthRepository _authRepository;
  final HiveInterface _hive;

  TokenInterceptor(
    this._authRepository,
    this._hive,
  );

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final box = await _hive.openBox<UserModel>('user');
    final token = box.get('user')?.token;

    if (token != null) {
      options.headers.addAll(<String, dynamic>{'Token': token});
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await _authRepository.logOut();
    }
    super.onError(err, handler);
  }
}
