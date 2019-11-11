import 'package:flutter/material.dart';

void main() => runApp(bottomBar());

class bottomBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return  Scaffold(
        body: homePage(),
      );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _select = 0;
  final _option = [
    { 'index': 0, 'title': '信息'},
    { 'index': 1, 'title': '通讯录'},
    { 'index': 2, 'title': '发现'},
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('底部导航栏实现'),
      ),
      body: Center(
        child: Text('${_option[_select]['title']}'),
      ),
      bottomNavigationBar: BottomNavigationBar(         //底部导航按钮，包括图标和文本
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('信息')),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), title: Text('通讯录')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('发现')),
        ],
        currentIndex: _select,      //当前选中的索引
//        fixedColor: Colors.deepPurple,//选项中项的颜色
        onTap: _onItemTapped,//选择按下处理
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _select = index;
    });
  }
}
