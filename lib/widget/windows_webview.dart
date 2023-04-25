// import 'package:desktop_webview_window/desktop_webview_window.dart';
// import 'package:flutter_text/init.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;
//
// class WebViewUtils {
//   static String _url = GlobalStore.url;
//
//   static late Webview webView;
//
//   static WebViewUtils? _init;
//
//   factory WebViewUtils() => _init ?? WebViewUtils._int();
//
//   static void onChangeUrl() {
//     _url = GlobalStore.url;
//   }
//
//   WebViewUtils._int() {
//     _initState();
//     _init = this;
//   }
//
//   static void _initState() async {
//     webView = await WebviewWindow.create(
//       configuration: CreateConfiguration(
//         title: '设置',
//         userDataFolderWindows: await _getDocument(),
//       ),
//     );
//     webView.onClose.whenComplete(() {
//       Log.info('Web窗口已关闭');
//       _init = null;
//     });
//     webView.launch(_url);
//     webView.addScriptToExecuteOnDocumentCreated('''
//       window.onload = function() {
//         document.cookie = "key=690575679";
//       }'''
//     );
//   }
//
//   static Future<String> _getDocument() async {
//     final document = await getApplicationDocumentsDirectory();
//     return path.join(document.path, 'flutter_desktop');
//   }
//
//   static void close() {
//     WebviewWindow.clearAll();
//   }
// }
