import 'package:flutter/material.dart';

void main() => runApp(new flexibleSpaceBar());

class flexibleSpaceBar extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'slider Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('flexibleSpaceBar 组件'),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,                                  //展开高度
                  floating: false,                                        //是否随滑动隐藏标题
                  pinned: true,                                           //是否固定在顶部
                  flexibleSpace: FlexibleSpaceBar(                        //可折叠的应用栏
                    centerTitle: true,
                    title: Text(
                      '可折叠的组件',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    background: Image.asset('images/sun.jpg', fit: BoxFit.cover,),
                  ),
                )
              ];
            },
            body: Center(
              child: Container(),
            )
          ),
        ),
    );
  }
}




