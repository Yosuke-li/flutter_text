import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_text/assembly_pack/music_play/music_model.dart';
import 'package:flutter_text/utils/file_utils.dart';

class MusicHelper {
  static Future<File> setAppLocateFile(File files) async {
    final Uint8List unit8 = files.readAsBytesSync();
    final File tempFile =
        await FileUtils.generateRandomTempFile(fileType: 'mp3');
    final File newFile = await tempFile.writeAsBytes(unit8);
    return newFile;
  }

  static Future<MusicModel> setModel() async {
    MusicModel model;

    return model;
  }
}
