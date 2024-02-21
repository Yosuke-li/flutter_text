import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DragText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('DragList可拖动列表组件'),
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
      // todo
      // child: DragList.handleless(
      //   // handleless取消拖动点，是整个widget都可以拖动
      //   items: data,
      //   //数据
      //   itemExtent: 72,
      //   //height
      //   scrollDirection: Axis.vertical,
      //   //数据方向
      //   itemBuilder: (context, DragItem item) {
      //     //or builder: (context, item, handle) handle是拖动点
      //     return Container(
      //       height: 72,
      //       child: Row(
      //         children: <Widget>[Spacer(), Text('${item}'), Spacer()],
      //       ),
      //     );
      //   },
      //   onItemReorder: (from, to) {
      //     //index from初始位置 to结束位置
      //     var temp = data[from];
      //     data[from] = data[to];
      //     data[to] = temp;
      //     setState(() {
      //       print('from: ${from}');
      //       print('to: ${to}');
      //       print(data);
      //     });
      //   },
      // ),
    );
  }
}
