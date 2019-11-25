import 'package:drag_list/drag_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(DragText());

class DragText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: DragDemo(),
    );
  }
}

class DragDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DragDemoState();
}

class DragDemoState extends State<DragDemo> {
  List<String> data = ['1', '2', '3', '4', '5', '6'];

  Widget build(BuildContext context) {
    return Container(
      child: DragList(         // handleless取消拖动点，是整个widget都可以拖动
        items: data,                      //数据
        itemExtent: 72,                   //height
        scrollDirection: Axis.vertical,   //数据方向
        builder: (context, item, handle) {        //or builder: (context, item, handle) handle是拖动点
          return Container(
            height: 72,
            child: Row(
              children: <Widget>[
                Spacer(),
                Text(item),
                Spacer(),
                handle
              ],
            ),
          );
        },
        onItemReorder: (from, to) {       //index from初始位置 to结束位置
          var temp = data[from];
          data[from] = data[to];
          data[to] = temp;
          setState(() {
            print('from: ${from}');
            print('to: ${to}');
            print(data);
          });
        },
      ),
    );
  }
}
