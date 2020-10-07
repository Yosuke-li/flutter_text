import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/global/store.dart';
import 'package:flutter_text/utils/toast_utils.dart';

void main() => runApp(StorageTest());

class StorageTest extends StatefulWidget {
  _StorageTestState createState() => _StorageTestState();
}

class _StorageTestState extends State<StorageTest> {
  TextEditingController controller = TextEditingController();

  void initState() {
    super.initState();
  }

  void save() {
    LocateStorage.setString('StorageTest', controller.text);
    ToastUtils.showToast(msg: '保存成功');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('缓存测试'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: controller,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '保存',
                ),
                onPressed: () {
                  save();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '获取缓存',
                ),
                onPressed: () {
                  final String getValue =
                      LocateStorage.getString('StorageTest');
                  ToastUtils.showToast(msg: getValue ?? '暂无缓存');
                  setState(() {
                    controller.text = getValue;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '获取所有缓存',
                ),
                onPressed: () {
                  LocateStorage.getAllKey();
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '清除缓存',
                ),
                onPressed: () {
                  LocateStorage.clean();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
