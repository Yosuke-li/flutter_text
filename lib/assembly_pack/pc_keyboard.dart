
import 'package:flutter/services.dart';
import 'package:flutter_text/init.dart';

class PCKeyboardPage extends StatefulWidget {

  @override
  _PCKeyboardPageState createState()=> _PCKeyboardPageState();
}

class Increment extends Intent {}

class Decrement extends Intent {}

class _PCKeyboardPageState extends State<PCKeyboardPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Shortcuts Widget定义键盘快捷键
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.arrowUp): Increment(),
        LogicalKeySet(LogicalKeyboardKey.arrowDown): Decrement(),
      },
      ///Actions调用绑定快捷键
      child: Actions(
        actions: {
          Increment: CallbackAction<Increment>(
              onInvoke: (intent) => _incrementCounter()),
          Decrement: CallbackAction<Decrement>(
              onInvoke: (intent) => _decrementCounter()),
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('pc keyboard controller'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}