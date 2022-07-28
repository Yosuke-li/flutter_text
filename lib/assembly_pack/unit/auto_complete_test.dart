import '../../init.dart';

class AutoCompleteTest extends StatefulWidget {
  const AutoCompleteTest({Key? key}) : super(key: key);

  @override
  State<AutoCompleteTest> createState() => _AutoCompleteTestState();
}

class _AutoCompleteTestState extends State<AutoCompleteTest> {
  static const List<String> _list = [
    'as',
    'siyer',
    'asnlo',
    'cujsd',
    'sdwdwax',
    'wdwdaosdl',
    'sda'
  ];

  Future<Iterable<String>> _searchType(String args) async {
    return _list.where((String element) => element.contains(args));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Auto-complete'),
        ),
        body: Column(
          children: [
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return _searchType(textEditingValue.text);
              },
              // optionsViewBuilder: (context, ) {
              //   return
              // },
            ),
            const Text('abcdefg'),
          ],
        ),
      ),
    );
  }
}
