import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class OptionsWithEquality extends Options with EquatableMixin {
  OptionsWithEquality({
    super.method,
    super.sendTimeout,
    super.receiveTimeout,
    super.extra,
    super.headers,
    super.preserveHeaderCase,
    super.responseType,
    super.contentType,
    super.validateStatus,
    super.receiveDataWhenStatusError,
    super.followRedirects,
    super.maxRedirects,
    super.persistentConnection,
    super.requestEncoder,
    super.responseDecoder,
    super.listFormat,
  });

  @override
  List<Object?> get props => [
        method,
        sendTimeout,
        receiveTimeout,
        extra,
        headers,
        preserveHeaderCase,
        responseType,
        contentType,
        validateStatus,
        receiveDataWhenStatusError,
        followRedirects,
        maxRedirects,
        persistentConnection,
        requestEncoder,
        responseDecoder,
        listFormat,
      ];
}
