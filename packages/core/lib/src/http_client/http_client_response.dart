import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class HttpClientResponse<T> extends Equatable {
  const HttpClientResponse({
    required this.data,
    this.statusCode,
  });

  final T data;

  final int? statusCode;

  @override
  List<Object?> get props => [data, statusCode];

  HttpClientResponse<T> copyWith({
    T? data,
    ValueGetter<int?>? statusCode,
  }) {
    return HttpClientResponse<T>(
      data: data ?? this.data,
      statusCode: statusCode != null ? statusCode() : this.statusCode,
    );
  }
}
