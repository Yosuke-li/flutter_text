import 'package:flutter/material.dart';
import 'package:self_utils/init.dart';

class BasicFutureWidget extends StatefulWidget {
  const BasicFutureWidget({super.key});

  @override
  State<BasicFutureWidget> createState() => _BasicFutureWidgetState();
}

class _BasicFutureWidgetState extends State<BasicFutureWidget> {

  /// 整理
  /// future的基本用法就是 future.delayed(duration(), () => {});
  /// future.then 主要是用来接收结果
  /// future.catchError和then里的onError参数主要是用来捕获错误消息，
  /// future.wait主要用于多个future的执行等待
  /// future.whenComplete里的内容无论future是否执行成功都会进入
  ///
  void testFutureOne() {
    Future<String>.delayed(const Duration(seconds: 2), () {
      return 'hello Future one';
    }).then(
      (String value) => print(value),
    );
  }

  void testFutureTwo() {
    Future<void>.delayed(
            const Duration(seconds: 3), () => throw AssertionError('error'))
        .then((value) {})
        .catchError((e) => print(e));
  }

  void testFutureThr() {
    Future<void>.delayed(
            const Duration(seconds: 3), () => throw AssertionError('error'))
        .then((value) {}, onError: (e) => print(e));
  }

  void testFutureFor() {
    Future<void>.delayed(
            const Duration(seconds: 2), () => throw AssertionError('Error'))
        .then((value) {})
        .catchError((onError) => print(onError))
        .whenComplete(() => null);

    /// whenComplete无论成功失败都会运行
  }

  void testFutureFif() {
    Future.wait([
      Future<String>.delayed(const Duration(seconds: 3), () => '3'),
      Future<String>.delayed(const Duration(seconds: 4), () => '5'),
    ]).then((List<String> value) => print(value[0] + value[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PopupTextAndExText(
          showText: testFutureOne.toString(),
          builderWidget: Container(
            child: const Text('future.then主要是用来接收异步结果'),
          ),
        ),
        PopupTextAndExText(
          showText: testFutureTwo.toString(),
          builderWidget: Container(
            child: const Text('future.catchError主要是用来捕捉异步任务中的错误信息'),
          ),
        ),
        PopupTextAndExText(
          showText: testFutureThr.toString(),
          builderWidget: Container(
            child: const Text(
                '在future里并不是只有future.catchError才用来捕捉错误，在then方法里还有一个参数onError也能用来捕捉异步任务中的错误信息'),
          ),
        ),
        PopupTextAndExText(
          showText: testFutureFor.toString(),
          builderWidget: Container(
            child: const Text(
                '当我们遇到异步执行的时候无论成功失败都需要做一些事情的时候，可以用到future.whenComplete'),
          ),
        ),
        PopupTextAndExText(
          showText: testFutureFif.toString(),
          builderWidget: Container(
            child: const Text(
                '在有些时候我们需要等待多个异步任务执行结束后才进一步的操作，'
                    '这个时候我们就会使用future.wait，只有等里面的所有future都执行成功后才会触发then的回调，但只要有一个future执行错误了，就会触发错误回调'),
          ),
        ),
      ],
    );
  }
}
