import '../../init.dart';

class KeyBoardListenerPage extends StatefulWidget {
  const KeyBoardListenerPage({Key? key}) : super(key: key);

  @override
  State<KeyBoardListenerPage> createState() => _KeyBoardListenerPageState();
}

//todo 可以监听键盘，但是不太行
class _KeyBoardListenerPageState extends State<KeyBoardListenerPage> {
  late FocusNode _node;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      _node = FocusNode();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KeyBoardListenerPage'),
      ),
      body: RawKeyboardListener(
        autofocus: true,
        onKey: (RawKeyEvent event) {
          Log.info(event);
        },
        focusNode: _node,
        child: Container(),
      ),
    );
  }
}
