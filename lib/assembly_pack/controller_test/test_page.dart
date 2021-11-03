import 'package:flutter_text/assembly_pack/controller_test/controller.dart';
import 'package:flutter_text/init.dart';

import 'listener.dart';

class TestControlPage extends StatefulWidget {
  @override
  _TestControlState createState() => _TestControlState();
}

class _TestControlState extends State<TestControlPage> {
  Controller _controller;

  @override
  void initState() {
    super.initState();
    _controller = Controller();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('controller 测试'),
      ),
      body: Container(
        child: Column(
          children: [
            ListenerPage(
              controller: _controller,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.goPreviousDay();
                  },
                  child: const Text('上一天'),
                ),
                GestureDetector(
                  onTap: () {
                    _controller.goNextDay();
                  },
                  child: const Text('下一天'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
