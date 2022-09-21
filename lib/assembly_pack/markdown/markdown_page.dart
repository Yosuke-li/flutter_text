import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../init.dart';
import 'drop_down.dart';

class MarkDownPage extends StatefulWidget {
  const MarkDownPage({Key? key}) : super(key: key);

  @override
  State<MarkDownPage> createState() => _MarkDownPageState();
}

class _MarkDownPageState extends State<MarkDownPage> {
  double _blockSpacing = 8.0;

  WrapAlignment _wrapAlignment = WrapAlignment.start;

  final Map<String, WrapAlignment> _wrapAlignmentMenuItems =
      Map<String, WrapAlignment>.fromIterables(
    WrapAlignment.values.map((WrapAlignment e) => e.toString()),
    WrapAlignment.values,
  );

  static const List<double> _spacing = <double>[4.0, 8.0, 16.0, 24.0, 32.0];
  final Map<String, double> _blockSpacingMenuItems =
      Map<String, double>.fromIterables(
    _spacing.map((double e) => e.toString()),
    _spacing,
  );

  late Future<String> data;

  @override
  void initState() {
    super.initState();
    data = rootBundle.loadString('assets/markdown.md');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('mark down demo'),
      ),
      body: FutureBuilder<String>(
        future: data,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                DropdownMenu<WrapAlignment>(
                  items: _wrapAlignmentMenuItems,
                  label: 'Wrap Alignment:',
                  initialValue: _wrapAlignment,
                  onChanged: (WrapAlignment? value) {
                    if (value != _wrapAlignment) {
                      setState(() {
                        _wrapAlignment = value!;
                      });
                    }
                  },
                ),
                DropdownMenu<double>(
                  items: _blockSpacingMenuItems,
                  label: 'Block Spacing:',
                  initialValue: _blockSpacing,
                  onChanged: (double? value) {
                    if (value != _blockSpacing) {
                      setState(() {
                        _blockSpacing = value!;
                      });
                    }
                  },
                ),
                Expanded(
                  child: Markdown(
                    key: Key(_wrapAlignment.toString()),
                    data: snapshot.data!,
                    imageDirectory: 'https://raw.githubusercontent.com',
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                      blockSpacing: _blockSpacing,
                      textAlign: _wrapAlignment,
                      pPadding: const EdgeInsets.only(bottom: 4.0),
                      h1Align: _wrapAlignment,
                      h1Padding: const EdgeInsets.only(left: 4.0),
                      h2Align: _wrapAlignment,
                      h2Padding: const EdgeInsets.only(left: 8.0),
                      h3Align: _wrapAlignment,
                      h3Padding: const EdgeInsets.only(left: 12.0),
                      h4Align: _wrapAlignment,
                      h4Padding: const EdgeInsets.only(left: 16.0),
                      h5Align: _wrapAlignment,
                      h5Padding: const EdgeInsets.only(left: 20.0),
                      h6Align: _wrapAlignment,
                      h6Padding: const EdgeInsets.only(left: 24.0),
                      unorderedListAlign: _wrapAlignment,
                      orderedListAlign: _wrapAlignment,
                      blockquoteAlign: _wrapAlignment,
                      codeblockAlign: _wrapAlignment,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
