import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/sql_user.dart';
import 'package:flutter_text/utils/login_api.dart';
import 'package:self_utils/utils/toast_utils.dart';

class TestAdd extends StatefulWidget {
  final SqlUser user;

  TestAdd(this.user);

  @override
  State<StatefulWidget> createState() {
    return TestAddState(user);
  }
}

class TestAddState extends State<TestAdd> {
  UserDbProvider provider = UserDbProvider();
  SqlUser user;
  late int count;

  LoginApi iCacheApi = LoginApi(); //todo interfaces 接口测试

  TestAddState(this.user);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getTableCount();
  }

  void getTableCount() async {
    final counts = await provider.getTableCountsV2();
    setState(() {
      count = counts;
    });
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = user.name??'';
    descriptionController.text = user.desc??'';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: nameController,
                decoration: const InputDecoration(helperText: "请输入名字"),
                onChanged: (value) {
                  user.name = nameController.text;
                }),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  user.desc = descriptionController.text;
                },
                decoration: InputDecoration(helperText: "请描述")),
          ),
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
      ToastUtils.showToast(msg: '没有用户可被删除');
      return;
    }

    int result = await provider.deleteUser(user.id??0);
    if (result != 0) {
      iCacheApi.deleteCache(user.id??0);
      Navigator.pop(context, true);
      ToastUtils.showToast(msg: '删除成功');
    } else {
      ToastUtils.showToast(msg: '错误');
    }
  }

  //保存
  void _save() async {
    int result;
    if (user.id == null) {
      user.id = count + 1; //id递增
      result = await provider.insertUser(user);
    } else {
      result = await provider.update(user);
    }

    int? t = user.id;
    String? n = user.name;
    String? d = user.desc;
    if (result != 0) {
      iCacheApi.setCache(user);
      Navigator.pop(context, true);
      ToastUtils.showToast(msg: '保存成功');
    } else {
      ToastUtils.showToast(msg: '保存失败');
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
