import 'package:dio/dio.dart';

class AuthKeyInterceptor extends Interceptor {
  final String authKey;

  AuthKeyInterceptor(
    this.authKey,
  );

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler,) async {
    options.headers.addAll(<String, dynamic>{'Authorization': authKey});
    super.onRequest(options, handler);
  }
}
