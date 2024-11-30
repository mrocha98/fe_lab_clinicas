import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/src/constants/storage_keys.dart';
import 'package:fe_lab_clinicas_core/src/http_client/dio/http_client_dio_impl.dart';
import 'package:fe_lab_clinicas_core/src/key_value_storage/key_value_storage_interface.dart';

class DioAuthInterceptor extends Interceptor {
  DioAuthInterceptor(this._kv);

  final KeyValueStorage _kv;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final RequestOptions(:headers, :extra) = options;
    const authHeaderKey = 'Authorization';
    headers.remove(authHeaderKey);

    if (extra case {HttpClientDioImpl.authKey: true}) {
      final token = await _kv.get<String>(StorageKeys.accessToken) as String;
      headers[authHeaderKey] = 'Bearer $token';
    }
    handler.next(options);
  }
}
