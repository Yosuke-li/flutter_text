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
  Future _saveImage(imageUrl) async {
    var response = await http.get(imageUrl);

    debugPrint(response.statusCode.toString());

    var filePath =
        await ImagePickerSaver.saveFile(fileData: response.bodyBytes);

    var savedFile = File.fromUri(Uri.file(filePath));

    setState(() {
       Future<File>.sync(() => savedFile);
       text = '保存成功';
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            _saveImage(
                'http://upload.art.ifeng.com/2017/0425/1493105660290.jpg');
          },
          child: Text('保存图片'),
        ),
      ),
    );
  }
}
