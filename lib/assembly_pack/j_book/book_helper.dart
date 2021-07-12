import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/file_utils.dart';

class BookHelper {
  static Future<List<File>> setAppLocateFile(List<File> files) async {
    final List<File> news = <File>[];
    for (int i = 0; i < files.length; i++) {
      final Uint8List unit8 = ArrayHelper.get(files, i).readAsBytesSync();
      final File tempFile = await FileUtils.generateRandomTempFile(fileType: 'epub');
      final File newFile = await tempFile.writeAsBytes(unit8);
      news.add(newFile);
    }
    return news;
  }
}