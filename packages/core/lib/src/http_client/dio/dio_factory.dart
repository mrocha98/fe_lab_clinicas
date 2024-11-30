import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/http_client/dio/interceptors/dio_auth_interceptor.dart';
import 'package:fe_lab_clinicas_core/src/http_client/dio/interceptors/dio_logger_interceptor.dart';

sealed class DioFactory {
  static Dio make({
    required DioAuthInterceptor dioAuthInterceptor,
    required DioLoggerInterceptor dioLoggerInterceptor,
    String baseUrl = '',
  }) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )..interceptors.addAll([
        dioAuthInterceptor,
        dioLoggerInterceptor, // must be the last one
      ]);
  }
}
