import 'package:flutter/material.dart';

class SelectTextPage extends StatefulWidget {
  @override
  _SelectTextState createState() => _SelectTextState();
}

class _SelectTextState extends State<SelectTextPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('123'),
      ),
      body: Container(
        /// 可复制选中的文字
        child: const SelectableText(
          '是的可视角度拉萨扩大什么两米长零秒现在但是到了；联动，萨拉吗联动理论自信材料空我看到。',
          showCursor: false,
        ),
      ),
    );
  }
}