import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LocalLog {
  static String _log = '';
  static Timer? timer;

  static Future<File> _getDocument() async {
    final document = await getTemporaryDirectory();
    final filePath =  path.join(document.path, 'log.log');

    final File file = File(filePath);
    if (!file.existsSync()) {
      file.createSync();
    }
    return file;
  }

  static void setLog(String log) {
    _log += '$log\n';
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
    timer = Timer(const Duration(milliseconds: 1000), () async {
      await _setLocalLog();
      timer = null;
    });
  }

  static Future<void> _setLocalLog() async {
    final File file = await _getDocument();
    if ((file.readAsBytesSync().lengthInBytes / 1024 / 1024) < 50) {
      final String a = await file.readAsString();
      if (a.isNotEmpty == true) {
        _log = '$a\n$_log';
      }
    }
    await file.writeAsString(_log);
    _log = '';
  }
}
