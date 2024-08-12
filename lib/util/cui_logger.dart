import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class CUILogger {
  static final CUILogger _instance = CUILogger._internal();
  static late Logger fileLogger;
  static late Logger consoleLogger;

  CUILogger._internal();

  factory CUILogger() {
    return _instance;
  }

  static ensureInitialized() async {
    Directory dirPath = await getApplicationCacheDirectory();
    fileLogger = Logger(
        printer:
            PrettyPrinter(printEmojis: false, printTime: true, colors: false),
        output: FileOutput(
            file: File("${dirPath.path}${Platform.pathSeparator}app.log")));
    consoleLogger = Logger(printer: PrettyPrinter(printEmojis: true));
  }

  static warn(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    CUILogger.fileLogger
        .w(message, time: time, error: error, stackTrace: stackTrace);
    if (kDebugMode) {
      CUILogger.consoleLogger
          .w(message, time: time, error: error, stackTrace: stackTrace);
    }
  }

  static error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    CUILogger.fileLogger
        .e(message, time: time, error: error, stackTrace: stackTrace);
    if (kDebugMode) {
      CUILogger.consoleLogger
          .e(message, time: time, error: error, stackTrace: stackTrace);
    }
  }
}
