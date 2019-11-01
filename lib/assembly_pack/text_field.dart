import 'package:flutter/material.dart';

void main() => runApp(new textField());

class textField extends StatelessWidget {
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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        TextField(
          controller: usernameController,
          textCapitalization: TextCapitalization.none,          //键盘大小写显示
          keyboardType: TextInputType.text,                     //键盘类型
          decoration: InputDecoration(                          //设置装饰
            contentPadding: EdgeInsets.all(10.0),               //控制input高度
            icon: Icon(Icons.person),
            labelText: "请输入你的手机号",
            helperText: "请输入注册的手机号"
          ),
          textInputAction: TextInputAction.go,                  //控制键盘的功能键，指enter键。
        ),
        TextField(
          controller: passwordController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            icon: Icon(Icons.lock),
            labelText: "请输入密码"
          ),
          obscureText: true,                                      //是否为密码
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: RaisedButton(
            onPressed: () {
              loginCheck();
            },
            child: Text('注册'),
          ),
        ),
      ],
    );
  }

  //简单的登录判断
  loginCheck() {
    var content = '登录成功';

    if ( usernameController.text.length != 11 ) {
        content = '请输入正确的手机号码';
    }
    if ( passwordController.text.length < 6 ) {
        content = '请输入6位数以上的密码';
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(content),
          actions: <Widget>[
            new FlatButton(
              child: new Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}

