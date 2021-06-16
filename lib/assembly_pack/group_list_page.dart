import 'package:flutter/material.dart';
import 'package:flutter_text/widget/group_list_widget.dart';

class GroupListPage extends StatefulWidget {

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupListPage> {
  final List<GroupListModel> data = [
    GroupListModel()..title = '111'..children = ['123', '456'],
    GroupListModel()..title = '111'..children = ['123', '456'],
    GroupListModel()..title = '111'..children = ['123', '456'],
    GroupListModel()..title = '111'..children = ['123', '456'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分组列表'),
      ),
      body: Container(
        child: GroupListWidget(list: data),
      ),
    );
  }
}