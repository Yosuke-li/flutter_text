import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/database/user_db_provider.dart';
import 'package:flutter_text/model/db_bean.dart';

class TestAdd extends StatefulWidget {
  final User user;
  TestAdd(this.user);

  @override
  State<StatefulWidget> createState() {
    return TestAddState(user);
  }
}

class TestAddState extends State<TestAdd> {
  UserDbProvider provider = UserDbProvider();
  User user;

  TestAddState(this.user);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    nameController.text = user.name;
    descriptionController.text = user.desc;

    return Scaffold(
      appBar: AppBar(
        title: Text('User detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: nameController,
                decoration: InputDecoration(helperText: "请输入名字"),
                onChanged:(value){
                  user.name = nameController.text;
                } ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: descriptionController,
                onChanged: (value){
                  user.desc = descriptionController.text;
                },
                decoration: InputDecoration(helperText: "请描述")),
          ) ,
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      '删除',
                    ),
                    onPressed: () {
                      _delete();
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      '保存',
                    ),
                    onPressed: () {
                      _save();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //删除
  void _delete() async {
    if (user.id == null) {
      _showAlertDialog('没有用户可被删除');
      return;
    }

    int result = await provider.deleteUser(user.id);
    if (result != 0) {
      Navigator.pop(context, true);
      _showAlertDialog("删除成功");
    } else {
      _showAlertDialog('错误');
    }
  }

  //保存
  void _save() async {
    int result;
    if (user.id == null) {
      user.id = new DateTime.now().millisecondsSinceEpoch;  //id 为当前时间戳
      result = await provider.insertUser(user);
    } else {
      result = await provider.update(user);
    }

    int t = user.id;
    String n = user.name;
    String d = user.desc;
    debugPrint("t:$t n:$n d:$d");
    debugPrint("result: $result");
    if (result != 0) {
      Navigator.pop(context, true);
      _showAlertDialog("保存成功");
    } else {
      _showAlertDialog("保存失败");
    }
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      // title: Text(tittle),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}