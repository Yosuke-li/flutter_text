import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:self_utils/utils/dio/dio_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shell/shell.dart';

class DownLoadPage extends StatefulWidget {
  const DownLoadPage({Key? key}) : super(key: key);

  @override
  State<DownLoadPage> createState() => _DownLoadPageState();
}

class _DownLoadPageState extends State<DownLoadPage> {
  String? now;
  Response? response;

  static Future<String> _getDocument() async {
    final document = await getApplicationDocumentsDirectory();
    return path.join(document.path, 'MicrosoftEdgeWebview2Setup.exe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final getPath = await _getDocument();
            response = await Request.downloadFile(
                'https://go.microsoft.com/fwlink/p/?LinkId=2124703', getPath,
                (int loaded, int total) {
              now = (loaded / total * 100).toStringAsFixed(2);
              setState(() {});
            }).whenComplete(() async {
              // 使用命令行
              final shell = Shell();
              await shell.start(getPath);
            });
          },
          child: RepaintBoundary(
            child: response == null ? const Text('下载并安装') : Text('$now%'),
          ),
        ),
      ),
    );
  }
}
