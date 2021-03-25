import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/test_add.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/utils/helpers/interfaces/login_api.dart';

void main() => runApp(TestDb());

class TestDb extends StatefulWidget {
  _TestDbState createState() => _TestDbState();
}

class _TestDbState extends State<TestDb> {
  UserDbProvider provider = UserDbProvider();
  List<User> userList = [];

  LoginApi iCacheApi = LoginApi(); //todo interfaces 接口测试
  
  void initState() {
    super.initState();
    getUserList();
  }

  Future<void> getUserList() async {
    final list = await provider.getAllUser();
    final counts = await provider.getTableCountsV2();
    
    final List<User> cache = await iCacheApi.getAllCache();
    print('counts: $counts');
    print('cache: ${jsonEncode(cache)}');
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
                              builder: (context) => TestAdd(e))).then((value) {
                        if (value == true) {
                          getUserList();
                        }
                      });
                    },
                    child: Container(
                      height: 30,
                      child:
                          Text('id: ${e.id} name: ${e.name} desc: ${e.desc}'),
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
                  MaterialPageRoute(builder: (context) => TestAdd(User())))
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
