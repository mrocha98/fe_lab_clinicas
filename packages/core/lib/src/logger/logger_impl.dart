import 'package:fe_lab_clinicas_core/src/logger/logger_interface.dart';
import 'package:logger/logger.dart' as l;

class LoggerImpl extends Logger {
  LoggerImpl(this._logger, [this._level = LogLevel.trace]);

  final l.Logger _logger;

  LogLevel _level;

  @override
  LogLevel get level => _level;

  @override
  set level(LogLevel value) {
    _level = value;
  }

  @override
  LogReturn trace(dynamic message) {
    if (canLog(LogLevel.trace)) {
      _logger.t(message);
    }
  }

  @override
  LogReturn debug(dynamic message) {
    if (canLog(LogLevel.debug)) {
      _logger.d(message);
    }
  }

  @override
  LogReturn info(dynamic message) {
    if (canLog(LogLevel.info)) {
      _logger.i(message);
    }
  }

  @override
  LogReturn warning(dynamic message, [Object? error, StackTrace? stackTrace]) {
    if (canLog(LogLevel.warning)) {
      _logger.w(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  LogReturn error(dynamic message, [Object? error, StackTrace? stackTrace]) {
    if (canLog(LogLevel.error)) {
      _logger.e(message, error: error, stackTrace: stackTrace);
    }
  }

  @override
  LogReturn fatal(dynamic message, [Object? error, StackTrace? stackTrace]) {
    if (canLog(LogLevel.fatal)) {
      _logger.f(message, error: error, stackTrace: stackTrace);
    }
  }
}
