import 'package:flutter/material.dart';
import 'package:flutter_text/model/img_model.dart';
import 'package:flutter_text/widget/banner.dart';

class WindowsMainPage extends StatefulWidget {
  const WindowsMainPage({Key? key}) : super(key: key);

  @override
  State<WindowsMainPage> createState() => _WindowsMainPageState();
}

class _WindowsMainPageState extends State<WindowsMainPage> {
  final List<ImageModel> _imgData = [
    ImageModel()
      ..fileImage = 'images/001.jpeg',
    ImageModel()
      ..fileImage = 'images/002.jpg',
    ImageModel()
      ..fileImage = 'images/003.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              WidgetBanner(_imgData),
            ],
          ),
        ),
      ),
    );
  }
}
