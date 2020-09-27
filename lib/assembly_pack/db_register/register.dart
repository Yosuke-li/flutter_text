import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_register/register_provider.dart';
import 'package:flutter_text/model/db_register.dart';
import 'package:flutter_text/widget/toast_utils.dart';

class RegisterPage extends StatefulWidget {
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  String account;
  String password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int count;

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
    final result = _formKey.currentState;
    DbRegister register = DbRegister();
    if (result.validate()) {
      register.id = count + 1;
      register.account = account;
      register.password = password;
      register.updateTime = DateTime.now().millisecondsSinceEpoch;
      register.createTime = DateTime.now().millisecondsSinceEpoch;

      final result = await RegisterProvider().insertUser(register);

      if (result != 0) {
        Navigator.pop(context);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(helperText: "请输入账号"),
                onSaved: (String val) {
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
                decoration: InputDecoration(helperText: "请输入密码"),
                onSaved: (String val) {
                  setState(() {
                    password = val;
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
                  '保存',
                ),
                onPressed: () {
                  ToastUtils.showToast(msg: 'sss');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
