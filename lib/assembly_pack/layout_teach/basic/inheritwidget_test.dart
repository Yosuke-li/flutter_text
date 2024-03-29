import 'package:flutter/material.dart';

class InheritedWidgetTest extends StatefulWidget {
  const InheritedWidgetTest({super.key});

  @override
  State<InheritedWidgetTest> createState() => _InheritedWidgetTestState();
}

class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  int _counter2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InheritedWidget test'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('inheritWidget build'),
            OnTapSelectWidget(
              data: _counter2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: _Test(),//子widget中依赖ShareDataWidget
                  ),
                  ElevatedButton(
                    child: Text("Increment"),
                    //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
                    onPressed: () => setState(() => ++_counter2),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnTapSelectWidget extends InheritedWidget {
  OnTapSelectWidget({Key? key, required this.data, required Widget child})
      : super(key: key, child: child);

  final int data; //需要共享的数据

  //定义一个便捷方法，方便访问数据
  static OnTapSelectWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OnTapSelectWidget>();
  }

  //该回调决定data变化的时候是否通知子树更新Widget
  @override
  bool updateShouldNotify(OnTapSelectWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _Test extends StatefulWidget {
  const _Test({super.key});

  @override
  State<_Test> createState() => _TestState();
}

class _TestState extends State<_Test> {
  @override
  Widget build(BuildContext context) {
    return Text(OnTapSelectWidget.of(context)?.data.toString()??'0');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies change');
  }
}
