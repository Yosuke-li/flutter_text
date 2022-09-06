import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_register/register_provider.dart';
import 'package:flutter_text/assembly_pack/db_register/register_table.dart';
import 'package:flutter_text/model/db_register.dart';
import 'package:self_utils/utils/toast_utils.dart';

class RegisterPage extends StatefulWidget {
  DbRegister? register;

  RegisterPage({this.register});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String? account;
  String? password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int count = 0;

  @override
  void initState() {
    super.initState();
    getTableCount();
  }

  Future<void> getTableCount() async {
    final counts = await RegisterProvider().getTableCountsV2();
    setState(() {
      count = counts;
    });
  }

  Future<void> onSave() async {
    final FormState? from = _formKey.currentState;
    final DbRegister register = DbRegister();
    if (from!=null && from.validate()) {
      from.save();
      final check = checkString();
      if (!check) {
        return;
      }

      register.id = count + 1;
      register.account = account ?? '';
      register.password = password ?? '';
      register.updateTime = DateTime.now().millisecondsSinceEpoch;
      register.createTime = DateTime.now().millisecondsSinceEpoch;

      final result = await RegisterProvider().insertUser(register);

      if (result != 0) {
        Navigator.pop(context);
        ToastUtils.showToast(msg: '注册成功');
      } else {
        ToastUtils.showToast(msg: '操作失败，请稍后重试');
      }
    }
  }

  bool checkString() {
    bool isCheck = false;
    if (account == null || account?.isEmpty == true) {
      ToastUtils.showToast(msg: '账号不能为空');
      return isCheck;
    }

    if (password == null || password?.isEmpty == true) {
      ToastUtils.showToast(msg: '密码不能为空');
      return isCheck;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterTable()));
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 20),
              child: const Text('注册表'),
            ),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(helperText: "请输入账号"),
                onSaved: (String? val) {
                  setState(() {
                    account = val;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: const InputDecoration(helperText: "请输入密码"),
                onSaved: (String? val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: CupertinoButton(
                color: Theme.of(context).primaryColorDark,
                child: const Text(
                  '保存',
                ),
                onPressed: () {
                  onSave();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
