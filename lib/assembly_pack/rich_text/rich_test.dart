// import 'dart:convert';
// import 'package:flutter/services.dart';
//
// import '../../init.dart';
//
// import 'package:flutter/src/widgets/text.dart' as Text;
// // import 'package:flutter_quill/flutter_quill.dart';
// // import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
//
// class RichTestPage extends StatefulWidget {
//   const RichTestPage({Key? key}) : super(key: key);
//
//   @override
//   State<RichTestPage> createState() => _RichTestPageState();
// }
//
// class _RichTestPageState extends State<RichTestPage> {
//   QuillController? controller;
//   final FocusNode focusNode = FocusNode();
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _load();
//     });
//   }
//
//   Future<void> _load() async {
//     final String result = await rootBundle.loadString('assets/rich_test.json');
//     final Document doc = Document.fromJson(jsonDecode(result));
//     setState(() {
//       controller = QuillController(
//           document: doc, selection: const TextSelection.collapsed(offset: 0));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (controller == null) {
//       return const Scaffold(body: Center(child: Text.Text('Loading...')));
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text.Text('富文本test'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               final Delta doc = controller!.document.toDelta();
//               String result = jsonEncode(doc);
//               File file = File('packages/flutter_text/assets/rich_test.json');
//               file.writeAsString(result);
//               Log.info(result);
//             },
//             child: Container(
//               child: const Text.Text('提交'),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           QuillToolbar.basic(
//             controller: controller!,
//             embedButtons: FlutterQuillEmbeds.buttons(),
//           ),
//           Expanded(
//             child: QuillEditor(
//               controller: controller!,
//               scrollController: ScrollController(),
//               scrollable: true,
//               focusNode: focusNode,
//               autoFocus: false,
//               readOnly: false,
//               placeholder: 'Add content',
//               expands: true,
//               padding: EdgeInsets.zero,
//               embedBuilders: FlutterQuillEmbeds.builders(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
