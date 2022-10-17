import '../../init.dart';
import 'package:flutter/src/widgets/text.dart' as Text;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class RichTestPage extends StatefulWidget {
  const RichTestPage({Key? key}) : super(key: key);

  @override
  State<RichTestPage> createState() => _RichTestPageState();
}

class _RichTestPageState extends State<RichTestPage> {
  late QuillController controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final Document doc = Document()..insert(0, 'Empty asset');
    setState(() {
      controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.Text('富文本test'),
      ),
      body: Column(
        children: <Widget>[
          QuillToolbar.basic(
            controller: controller,
            embedButtons: FlutterQuillEmbeds.buttons(),
          ),
          Expanded(child: QuillEditor(
            controller: controller,
            scrollController: ScrollController(),
            scrollable: true,
            focusNode: focusNode,
            autoFocus: false,
            readOnly: false,
            placeholder: 'Add content',
            expands: true,
            padding: EdgeInsets.zero,
            embedBuilders: FlutterQuillEmbeds.builders(),
          ),),
        ],
      ),
    );
  }
}
