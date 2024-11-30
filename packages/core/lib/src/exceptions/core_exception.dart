import 'package:meta/meta.dart';

@immutable
abstract class CoreException implements Exception {
  const CoreException({this.message});

  final String? message;
}
