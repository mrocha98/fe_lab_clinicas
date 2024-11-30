import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/exceptions/http_client_exception.dart';
import 'package:fe_lab_clinicas_core/src/fp/either.dart';
import 'package:fe_lab_clinicas_core/src/http_client/dio/options_with_equality.dart';
import 'package:fe_lab_clinicas_core/src/http_client/http_client_interface.dart';
import 'package:fe_lab_clinicas_core/src/http_client/http_client_response.dart';

class HttpClientDioImpl implements HttpClient {
  HttpClientDioImpl(this._dio);

  final Dio _dio;

  static const authKey = 'DIO_AUTH_KEY';

  @override
  HttpClient auth() {
    _dio.options.extra[authKey] = true;
    return this;
  }

  @override
  HttpClient unAuth() {
    _dio.options.extra[authKey] = false;
    return this;
  }

  @override
  Future<Either<HttpClientException, HttpClientResponse<R>>>
      get<R extends Object>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<R>(
        path,
        options: OptionsWithEquality(headers: headers),
        queryParameters: queryParameters,
      );
      return Right(_dioResponseConverter<R>(response));
    } on DioException catch (ex) {
      return Left(_dioExceptionConverter(ex));
    }
  }

  @override
  Future<Either<HttpClientException, HttpClientResponse<R>>>
      post<R extends Object>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post<R>(
        path,
        data: data,
        options: OptionsWithEquality(headers: headers),
        queryParameters: queryParameters,
      );
      return Right(_dioResponseConverter<R>(response));
    } on DioException catch (ex) {
      return Left(_dioExceptionConverter(ex));
    }
  }

  HttpClientResponse<T> _dioResponseConverter<T>(Response<T> response) {
    return HttpClientResponse<T>(
      data: response.data as T,
      statusCode: response.statusCode,
    );
  }

  HttpClientException _dioExceptionConverter(DioException ex) {
    return HttpClientException(
      message: ex.message,
      statusCode: ex.response?.statusCode,
      error: ex,
      response: HttpClientResponse(
        data: ex.response?.data,
        statusCode: ex.response?.statusCode,
      ),
    );
  }
}
