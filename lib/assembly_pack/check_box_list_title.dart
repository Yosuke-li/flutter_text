import 'package:flutter/material.dart';

class CheckBoxListTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'checkBoxListTitle Study',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('checkBoxListTitle 组件'),
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

  bool is_male = false;
  bool is_female = false;
  bool _value = false;
  bool is_check = false;
  List<bool> is_checks = [ false, false, false, false ];

  void _valueChanged(bool value) {
    for ( var i = 0; i < is_checks.length; i++ ) {
      is_checks[i] = value;
    }
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Center(
          child: CheckboxListTile(
            value: _value,
            selected: true,
            onChanged: _valueChanged,
            dense: false,                                           //是否密集垂直
            isThreeLine: false,                                     //是否显示三行文本
            title: Text('整个内容'),
            controlAffinity: ListTileControlAffinity.platform,      //勾选框、标题和图标的位置：platform根据不同的平台，来显示对话框的位置
            subtitle: Text('勾选下列选项'),
            secondary: Icon(Icons.archive),                         //最左边的一个控件
            activeColor: Colors.red,                                //选中时的填充颜色
          ),
        ),
        Center(
          child: CheckboxListTile(
            value: is_checks[0],
            onChanged: (bool) {
              setState(() {
                is_checks[0] = bool;
              });
            },
            title: Text('选项1'),
            controlAffinity: ListTileControlAffinity.platform,
            activeColor: is_checks[0] ? Colors.red : Colors.grey,
          ),
        ),
        Center(
          child: CheckboxListTile(
            value: is_checks[1],
            onChanged: (bool) {
              setState(() {
                is_checks[1] = bool;
              });
            },
            title: Text('选项2'),
            controlAffinity: ListTileControlAffinity.platform,
            activeColor: is_checks[1] ? Colors.red : Colors.grey,
          ),
        ),
        Center(
          child: CheckboxListTile(
            value: is_checks[2],
            onChanged: (bool) {
              setState(() {
                is_checks[2] = bool;
              });
            },
            title: Text('选项3'),
            controlAffinity: ListTileControlAffinity.platform,
            activeColor: is_checks[2] ? Colors.red : Colors.grey,
          ),
        ),
        Center(
          child: CheckboxListTile(
            value: is_checks[3],
            onChanged: (bool) {
              setState(() {
                is_checks[3] = bool;
              });
            },
            title: Text('选项4'),
            controlAffinity: ListTileControlAffinity.platform,
            activeColor: is_checks[3] ? Colors.red : Colors.grey,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Text('ChekBox 单选选择器'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('男'),
                      Checkbox(
                        value: is_male,
                        onChanged: (isMan) {
                          setState(() {
                            if (isMan) {
                              is_male = true;
                              is_female = false;
                            }
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('女'),
                      Checkbox(
                        value: is_female,
                        onChanged: (isFemale) {
                          setState(() {
                            if (isFemale) {
                              is_male = false;
                              is_female = true;
                            }
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

