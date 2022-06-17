import 'package:webview_flutter/webview_flutter.dart';

import '../init.dart';

class WebviewTest extends StatefulWidget {
  const WebviewTest({Key? key}) : super(key: key);

  @override
  State<WebviewTest> createState() => _WebviewTestState();
}

class _WebviewTestState extends State<WebviewTest> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('webview'),
      ),
      body: const WebView(initialUrl: 'https://flutter.cn',),
    );
  }
}
