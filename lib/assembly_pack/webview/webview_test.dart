import 'package:flutter_text/widget/windows_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cef/webview_cef.dart' as cef;

import '../../init.dart';
import 'method.dart';

class WebViewTest extends StatefulWidget {
  const WebViewTest({Key? key}) : super(key: key);

  @override
  State<WebViewTest> createState() => _WebViewTestState();
}

class _WebViewTestState extends State<WebViewTest> {
  final _controller = cef.WebViewController();
  final _textController = TextEditingController();
  String title = '';

  List<WebModel> webs = [];
  List<PopupMenuItem<WebModel>> popMenu = [];

  @override
  void initState() {
    super.initState();
    if (!GlobalStore.isMobile) {
      // WebViewUtils();
      init();
      _getWebs();
    }
  }

  void _getWebs() {
    webs = WebCollect.getAllWebs();
    popMenu = webs
        .map(
          (WebModel e) => PopupMenuItem<WebModel>(
            onTap: () {
              _textController.text = e.url!;
              _controller.loadUrl(e.url!);
            },
            child: Text('${e.title}'),
          ),
        )
        .toList();
    setState(() {});
  }

  void init() async {
    String url = 'https://bing.com';
    _textController.text = url;
    await _controller.initialize();
    await _controller.loadUrl(url);
    _controller.setWebviewListener(cef.WebviewEventsListener(
      onTitleChanged: (t) {
        setState(() {
          title = t;
        });
      },
      onUrlChanged: (url) {
        _textController.text = url;
      },
    ));
    _controller.addListener(() {
      _controller.ready;
      Log.info('message');
    });
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    if (!GlobalStore.isMobile) {
      _controller.removeListener(() { });
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalStore.isMobile
          ? AppBar(
              title: const Text('webview'),
            )
          : null,
      body: GlobalStore.isMobile
          ? const WebView(
              initialUrl: 'https://bing.com/',
              javascriptMode: JavascriptMode.unrestricted,
            )
          : Container(
              child: Column(
                children: [
                  RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (RawKeyEvent event) {
                      if (event.logicalKey.keyLabel == 'Enter') {}
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: MaterialButton(
                            onPressed: () {
                              _controller.reload();
                            },
                            child: const Icon(Icons.refresh),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: MaterialButton(
                            onPressed: () {
                              _controller.goBack();
                            },
                            child: const Icon(Icons.arrow_left),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: MaterialButton(
                            onPressed: () {
                              _controller.goForward();
                            },
                            child: const Icon(Icons.arrow_right),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: MaterialButton(
                            onPressed: () {
                              _controller.openDevTools();
                            },
                            child: const Icon(Icons.developer_mode),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            child: TextField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0),
                                constraints: BoxConstraints(maxHeight: 35)
                              ),
                              controller: _textController,
                              onSubmitted: (url) {
                                if (url.startsWith('http://')) {
                                  _textController.text = url;
                                  _controller.loadUrl(url);
                                } else if (url.startsWith('https://')) {
                                  _textController.text = url;
                                  _controller.loadUrl(url);
                                } else if (url.startsWith('www.')) {
                                  _textController.text = 'https://$url';
                                  _controller.loadUrl('https://$url');
                                } else {
                                  _textController.text = url;
                                  _controller.loadUrl(
                                      'https://www.baidu.com/s?wd=$url');
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: MaterialButton(
                            onPressed: () {
                              WebCollect.setWebs(WebModel()
                                ..url = _textController.text
                                ..title = title);
                              _getWebs();
                            },
                            child: webs.any((WebModel element) =>
                                    element.url == _textController.text)
                                ? const Icon(Icons.star)
                                : const Icon(Icons.star_border),
                          ),
                        ),
                        PopupMenuButton<WebModel>(
                          child: Container(
                            height: 40,
                            width: 40,
                            child: const Icon(Icons.collections),
                          ),
                          offset: const Offset(40, 40),
                          itemBuilder: (BuildContext context) => popMenu,
                        ),
                      ],
                    ),
                  ),
                  _controller.value
                      ? Expanded(
                          child: cef.WebView(_controller),
                        )
                      : Container(
                          child: const Text('warning'),
                        ),
                ],
              ),
            ),
    );
  }
}
