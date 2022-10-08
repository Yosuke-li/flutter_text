import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';
import 'package:self_utils/widget/markdown/format.dart';
import 'package:self_utils/widget/markdown/markdown_text_input.dart';

import '../../init.dart';

class MarkdownEditor extends StatefulWidget {
  const MarkdownEditor({Key? key}) : super(key: key);

  @override
  State<MarkdownEditor> createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  String value = '';
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      Log.info(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mark down Editor'),
      ),
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: MarkdownTextInput(
                (String val) {
                  value = val;
                  setState(() {});
                },
                value,
                label: 'cacas',
                actions: MarkdownType.values,
                controller: controller,
              ),
            ),
          ),
          Expanded(
            child: Markdown(
              data: value,
              controller: scrollController,
              onTapLink: (text, href, ___) {
                Log.info(href ?? '');
              },
              imageBuilder: (uri, _, __) {
                if (uri.path.contains('.svg')) {
                  return SvgPicture.asset(
                    'assets/relaxation.svg',
                  );
                } else {
                  return Image.asset(uri.path);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
