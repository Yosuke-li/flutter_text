import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_saver/image_picker_saver.dart';

void main() => runApp(TextT());

class TextT extends StatefulWidget {
  TextState createState() => TextState();
}

class TextState extends State<TextT> {
  String text = '保存图片';
  List<String> ttsList = [];
  int count = 10;
  String _chapterInfo =
      '市科技局打开拉萨记录肯德基雷克萨尽量扩大解释拉开距离喀什就打开拉萨就电力科技撒赖卡洛斯肯德基雷克萨就离开杀了及代理商卡进来';

  void getTtsList() {
    ttsList = [];
    for (int first = 0; first < _chapterInfo.length;) {
      if (first + count >= _chapterInfo.length) {
        int last = _chapterInfo.length;
        ttsList.add(_chapterInfo.substring(first, last));
        break;
      } else {
        ttsList.add(_chapterInfo.substring(first, first + count));
        first = first + count;
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            getTtsList();
            print(ttsList);
          },
          child: Text('保存图片'),
        ),
      ),
    );
  }
}
