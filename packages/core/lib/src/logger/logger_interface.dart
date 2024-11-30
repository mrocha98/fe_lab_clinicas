import 'dart:async';

import 'package:meta/meta.dart';

enum LogLevel {
  silent(0),
  fatal(1),
  error(2),
  warning(3),
  info(4),
  debug(5),
  trace(6);

  const LogLevel(this._ranking);

  final int _ranking;

  bool operator >=(LogLevel other) {
    return _ranking >= other._ranking;
  }
}

typedef LogReturn = FutureOr<void>;

abstract class Logger {
  LogLevel get level;

  set level(LogLevel value);

  LogReturn trace(dynamic message);

  LogReturn debug(dynamic message);

  LogReturn info(dynamic message);

  LogReturn warning(dynamic message, [Object? error, StackTrace? stackTrace]);

  LogReturn error(dynamic message, [Object? error, StackTrace? stackTrace]);

  LogReturn fatal(dynamic message, [Object? error, StackTrace? stackTrace]);

  final List<dynamic> _appended = [];

  @protected
  bool canLog(LogLevel level) {
    return this.level >= level;
  }

  void append(dynamic message) {
    _appended.add(message);
  }

  LogReturn releaseAppended([LogLevel level = LogLevel.trace]) {
    final message = _appended.join('\n');
    _appended.clear();
    final method = switch (level) {
      LogLevel.silent => (_) {},
      LogLevel.fatal => fatal,
      LogLevel.error => error,
      LogLevel.warning => warning,
      LogLevel.info => info,
      LogLevel.debug => debug,
      LogLevel.trace => trace,
    };
    return method(message);
  }
}
