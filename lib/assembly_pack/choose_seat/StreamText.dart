import 'package:flutter/material.dart';
import 'package:flutter_text/init.dart';

class StreamTextPage extends StatefulWidget {
  @override
  _StreamTextState createState() => _StreamTextState();
}

///yield为周围的async*函数输出流添加一个值，类似于return，但不会终止函数。
class _StreamTextState extends State<StreamTextPage> {
  int count = 0;

  Stream<int> getInt() async* {
    for (int i = 0; i < 10; i++) {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield count++;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Center(
        child: StreamBuilder<void>(
          stream: getInt(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container(
              child: Text('${snapshot.data ?? 0}'),
            );
          },
        ),
      ),
    );
  }
}
