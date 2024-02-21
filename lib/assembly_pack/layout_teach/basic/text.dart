import 'package:flutter/material.dart';
import 'package:self_utils/init.dart';

class BasicTextWidget extends StatefulWidget {
  const BasicTextWidget({super.key});

  @override
  State<BasicTextWidget> createState() => _BasicTextWidgetState();
}

class _BasicTextWidgetState extends State<BasicTextWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /// [text]用于显示简单的文本样式，包含一些控制文本显示样式的属性。
        /// textAlign 文本的对齐方式
        /// maxLines, overflow文本显示的最大行数和超过数量显示的样式
        /// textScaleFactor代表了文本的缩放
        PopupTextAndExText(
          showText:
              '[text]用于显示简单的文本样式，包含一些控制文本显示样式的属性。textAlign 文本的对齐方式 maxLines, overflow文本显示的最大行数和超过数量显示的样式, textScaleFactor代表了文本的缩放',
          builderWidget: Column(
            children: const <Widget>[
              Text(
                'Hello world',
                textAlign: TextAlign.end,
              ),
              Text(
                'Hello world,Hello world,Hello world',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Hello world',
                textScaleFactor: 1.5,
              ),
            ],
          ),
        ),

        /// textStyle用于修改文本显示的样式。
        ///
        PopupTextAndExText(
          showText: 'textStyle用于修改文本显示的样式。',
          builderWidget: Text(
            'Hello world',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 19,
              height: 1.2,
              fontFamily: 'Courier',
              background: Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed,
            ),
          ),
        ),

        /// Text的所有文本只能按同一种样式，如果我们需要对一个text内容的不同部分按不同样式处理，这个时候就用上TextSpan，
        ///
        const PopupTextAndExText(
          showText:
              '/// Text的所有文本只能按同一种样式，如果我们需要对一个text内容的不同部分按不同样式处理，这个时候就用上TextSpan，',
          builderWidget: Text.rich(
            TextSpan(children: <TextSpan>[
              TextSpan(text: 'Hello'),
              TextSpan(text: 'world', style: TextStyle(color: Colors.blue))
            ]),
          ),
        ),
        PopupTextAndExText(
          showText: '在Widget树中，文本的样式默认是可以被继承的，而DefaultTextStyle正是用于设置默认文本样式的, 可通过inherit：false设置不继承样式',
          builderWidget: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20.0,
            ),
            child: Column(
              children: const <Widget>[
                Text('hello world'),
                Text('I am ', style: TextStyle(inherit: false, color: Colors.yellow),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
