import 'package:dio/dio.dart';

class DioFactory {
  Dio create({String? baseUrl, List<Interceptor> interceptors = const []}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
      ),
    )..interceptors.addAll(interceptors);
  }
}
