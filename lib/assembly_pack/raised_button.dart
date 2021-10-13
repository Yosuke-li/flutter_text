import 'package:flutter/material.dart';

class RaisedButtonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'slider Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('layoutRow 组件'),
        ),
        body: Center(
          child: contextPage(),
        ),
      ),
    );
  }
}

class contextPage extends StatefulWidget  {

  @override
  State<StatefulWidget> createState() => contextPageState();

}

class contextPageState extends State<contextPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 26.0),
        ),
        color: Colors.green,                                                          //按钮背景颜色
        colorBrightness: Brightness.dark,                                             //按钮亮度
        disabledColor: Colors.grey,                                                   //失效时的背景颜色
        disabledTextColor: Colors.grey,                                               //失效时的文本颜色
        textColor: Colors.white,                                                      //文本颜色
        textTheme: ButtonTextTheme.normal,                                            //按钮主题
        splashColor: Colors.blue,                                                     //墨汁飞溅的颜色
        clipBehavior: Clip.antiAlias,                                                 //抗锯齿能力
        padding: new EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 20),
        shape: RoundedRectangleBorder(                                                //border圆角矩形边框
//          side: new BorderSide(
//            width: 2.0,
//            color: Colors.white,
//            style: BorderStyle.solid,
//          ),
          borderRadius: BorderRadius.only(                                             //border边框圆角
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
        onPressed: () {                                                                 //设置了onpressed以上颜色才有效果，不然就是失效状态
          print('按钮按下操作');
        },
      ),
    );
  }
}

