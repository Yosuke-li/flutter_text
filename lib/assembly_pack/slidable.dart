import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:drag_list/drag_list.dart';

void main() => runApp(SlidableText());

class SlidableText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Slidable组件'),
        ),
        body: SlidableDemo(),
      );
  }
}

class SlidableDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SlidableState();
}

class SlidableState extends State<SlidableDemo> {
  List<String> data = ['1', '2', '3', '4', '5', '6'];

  Widget build(BuildContext context) {
    return Container(
      child: DragList(          // handleless取消拖动点，是整个widget都可以拖动
        items: data,            //数据
        itemExtent: 72,         //height
        scrollDirection: Axis.vertical,     //数据方向
        itemBuilder: (context, item, handle) {    //or builder: (context, item, handle) handle是拖动点
          return Container(
            height: 72,
            child:  ListView(
              children: <Widget>[
                Slidable(
                  actionPane: SlidableScrollActionPane(),
                  actions: <Widget>[],        // 左侧
                  child: Container(
                    height: 72,
                    child: Row(
                      children: <Widget>[
                        Spacer(),
                        Text('${item}'),
                        Spacer(),
                        handle
                      ],
                    ),
                  ),
                  secondaryActions: <Widget>[ //右侧按钮列表
                    IconSlideAction(
                        caption: 'More',
                        color: Colors.black45,
                        icon: Icons.more_horiz,
                        onTap: () => {}
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      closeOnTap: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        onItemReorder: (from, to) {
          //index from初始位置 to结束位置
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