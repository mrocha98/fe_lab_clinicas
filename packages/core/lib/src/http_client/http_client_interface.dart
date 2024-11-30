import 'package:fe_lab_clinicas_core/src/exceptions/exceptions.dart';
import 'package:fe_lab_clinicas_core/src/fp/fp.dart';
import 'package:fe_lab_clinicas_core/src/http_client/http_client_response.dart';

abstract interface class HttpClient {
  HttpClient auth();

  HttpClient unAuth();

  Future<Either<HttpClientException, HttpClientResponse<R>>>
      get<R extends Object>(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<HttpClientException, HttpClientResponse<R>>>
      post<R extends Object>(
    String path, {
    Object? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}
