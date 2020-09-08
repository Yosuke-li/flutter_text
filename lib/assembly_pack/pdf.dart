import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
    String result;
    final dir = await getTemporaryDirectory();
    // prepare the file and type extension that you want to download
    final filePath =
        dir.path + '${Random().nextInt(4294967000)}' + ('/example.pdf');
    try {
      await dio.download(url, filePath);
      result = await ImageGallerySaver.saveFile(filePath);
    } catch (e) {
      result = e;
    }
    print(result);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 128),
        child: FlatButton(
          padding: const EdgeInsets.all(0),
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
                fontSize: (46),
                color: const Color(0xffffffff),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
