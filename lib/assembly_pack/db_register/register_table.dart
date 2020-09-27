import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_register/register.dart';
import 'package:flutter_text/assembly_pack/db_register/register_provider.dart';
import 'package:flutter_text/model/db_register.dart';
import 'package:flutter_text/model/db_user.dart';

class RegisterTable extends StatefulWidget {
  _RegisterTableState createState() => _RegisterTableState();
}

class _RegisterTableState extends State<RegisterTable> {
  RegisterProvider provider = RegisterProvider();
  List<DbRegister> userList = [];

  void initState() {
    super.initState();
    getUserList();
  }

  Future<void> getUserList() async {
    final list = await provider.getAllUser();
    final counts = await provider.getTableCountsV2();
    print('counts: $counts');
    setState(() {
      userList = list;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sql 练习'),
      ),
      body: Container(
        child: RepaintBoundary(
          child: ListView(
            children: userList
                ?.map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RegisterPage(register: e))).then((value) {
                        if (value == true) {
                          getUserList();
                        }
                      });
                    },
                    child: Container(
                      height: 30,
                      child: Text(
                          'id: ${e.id} account: ${e.account} password: ${e.password} '),
                    ),
                  ),
                )
                ?.toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()))
              .then((value) {
            if (value == true) {
              getUserList();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
