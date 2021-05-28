import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_text/utils/file_to_locate.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:ios_share/ios_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

void main() => runApp(pdfView());

class pdfView extends StatefulWidget {
  pdfViewState createState() => pdfViewState();
}

class pdfViewState extends State<pdfView> {
  String url =
      'http://fp.baiwang.com/fp/d?d=9C4E8DD9749B11892ABA67A22E849893C02EA2A0CCF7128F92758E4F57DC701C';

  Future<void> _downLoad() async {
    Dio dio = Dio();
    final dir = await getTemporaryDirectory();
    // prepare the file and type extension that you want to download
    final filePath =
        dir.path + '${Random().nextInt(4294967000)}' + ('/example.pdf');
    try {
      if (Platform.isAndroid) {
        await dio.download(url, filePath);
        await ImageGallerySaver.saveFile(filePath);
        ToastUtils.showToast(msg: '文件已保存到$filePath');
      } else if (Platform.isIOS) {
        await IosShare.iosShareHelper(filePath);
      }
    } catch (e) {
      rethrow;
    }
  }

  //本地assert保存
  Future<void> _assertDownLoad() async {
    try {
      final bytes = await FileToLocateHelper.getAssetFileBytes(
          assetPath: 'assets/index.pdf');
      FileToLocateHelper.saveFileToLocated('魔法禁书目录.pdf', byteUrl: bytes,
          onSuccessToast: (String name) {
        ToastUtils.showToast(msg: '保存成功');
      });
    } catch (error, stack) {
      rethrow;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 128),
        child: Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                _downLoad();
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xe6ff7e50), Color(0xe6fa8078)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '下载到本地',
                  style: TextStyle(
                    fontSize: screenUtil.adaptive(46),
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ),
            Container(
              height: screenUtil.adaptive(20),
            ),
            FloatingActionButton(
              onPressed: () async {
                await _assertDownLoad();
              },
              child: Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Color(0xe6ff7e50), Color(0xe6fa8078)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'assert文件下载',
                  style: TextStyle(
                    fontSize: screenUtil.adaptive(46),
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
