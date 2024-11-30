import 'package:equatable/equatable.dart';
import 'package:fe_lab_clinicas_core/src/exceptions/core_exception.dart';
import 'package:fe_lab_clinicas_core/src/http_client/http_client_response.dart';
import 'package:flutter/foundation.dart';

class HttpClientException extends CoreException with EquatableMixin {
  const HttpClientException({
    required this.error,
    required this.response,
    super.message,
    this.statusCode,
  });

  final int? statusCode;

  final dynamic error;

  final HttpClientResponse<dynamic> response;

  @override
  List<Object?> get props => [
        statusCode,
        error,
        response,
        message,
      ];

  HttpClientException copyWith({
    ValueGetter<int?>? statusCode,
    dynamic error,
    HttpClientResponse<dynamic>? response,
  }) {
    return HttpClientException(
      statusCode: statusCode != null ? statusCode() : this.statusCode,
      error: error ?? this.error,
      response: response ?? this.response,
    );
  }
}
