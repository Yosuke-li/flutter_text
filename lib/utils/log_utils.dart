import 'dart:developer';

enum LogLevel { DEBUG, INFO, WARNING, ERROR }

class Log {
  static Log _log;
  static bool _debugMode = false;
  static int _maxLen = 128;

  //单例
  factory Log({bool isDebug, int maxLen}) => _log ?? Log._init(isDebug: isDebug, maxLen: maxLen);

  Log._init({bool isDebug = false, int maxLen = 128}) {
    _debugMode = isDebug;
    _maxLen = maxLen;
    _log = this;
  }

  static void debug(Object message, {StackTrace stackTrace}) {
    if (_debugMode) {
      log('${LogLevel.DEBUG.toString()} -- ${DateTime.now().toString()} -- ${message.toString()}',
          stackTrace: stackTrace, level: 0);
    }
  }

  static void info(Object message) {
    if (_debugMode) {
      log('${LogLevel.INFO.toString()} -- ${DateTime.now().toString()} -- $message',
          level: 500);
    }
  }

  static void warning(Object message, {StackTrace stackTrace}) {
    log('${LogLevel.WARNING.toString()} -- ${DateTime.now().toString()} -- $message',
        stackTrace: stackTrace, level: 1000);
  }

  static void error(Object message, {StackTrace stackTrace}) {
    log('${LogLevel.ERROR.toString()} -- ${DateTime.now().toString()} -- $message',
        stackTrace: stackTrace, level: 2000);
  }
}
