import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_text/init.dart';
import 'package:image_compression/image_compression.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:flutter_text/utils/compress.dart';
import 'package:shell/shell.dart';

class DesktopDropText extends StatefulWidget {
  const DesktopDropText({Key? key}) : super(key: key);

  @override
  _DesktopDropTextState createState() => _DesktopDropTextState();
}

class _DesktopDropTextState extends State<DesktopDropText> {
  XFile? _file;

  void _dragDone(DropDoneDetails details) async {
    _file = details.files.last;
    Log.info('_file.path: ${_file?.path}');
    Log.info('_file.name: ${_file?.name}');
    Log.info('_file.mimeType: ${_file?.mimeType}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拖拽进程序'),
      ),
      body: DropTarget(
        onDragDone: _dragDone,
        child: _file == null ? _upload() : _view(_file!),
      ),
    );
  }

  Widget _upload() {
    return Center(
      child: Container(
        child: const Text('拖拽图片打开'),
      ),
    );
  }

  // 显示数据
  Widget _view(XFile file) {
    final File f = File(file.path);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            child: Image.file(f),
          ),
          Container(
            child: Text(
                '图片大小：${(f.readAsBytesSync().lengthInBytes / 1024 / 1024).toStringAsFixed(2)}MB'),
          ),
          ElevatedButton(
            onPressed: () {
              _compress();
            },
            child: const Text('压缩图片'),
          )
        ],
      ),
    );
  }

  Future<void> _compress() async {
    final shell = Shell();
    if (_file == null) {
      return;
    }
    final File f = File(_file!.path);
    final ImageFile input =
        ImageFile(rawBytes: f.readAsBytesSync(), filePath: f.path);
    final ImageFile result =
        await compressInQueue(ImageFileConfiguration(input: input));

    if (result != null) {
      final Directory dir = await path_provider.getTemporaryDirectory();
      final String filePath = path.join(dir.path, '${_file!.name}');
      Log.info(filePath);
      final File file = File(filePath);
      if (!file.existsSync()) {
        file.createSync();
      }
      await file.writeAsBytes(result.rawBytes).whenComplete(
            () => shell.start('open ${dir.path}'),
          );
    }
  }
}
