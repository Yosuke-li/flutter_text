import 'package:flutter/material.dart';
import 'package:flutter_text/api/pear_video.dart';

void main() => runApp(PearVideoFirstPage());

class PearVideoFirstPage extends StatefulWidget {
  PearVideoFirstPageState createState() => PearVideoFirstPageState();
}

class PearVideoFirstPageState extends State<PearVideoFirstPage> {
  void _getPearVideoList() async {
    final result = await PearVideoApi().getPearVideoList();
    print(result);
  }

  void initState() {
    super.initState();
    _getPearVideoList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: Center(
        child: Text('ListView'),
      ),
    );
  }
}
