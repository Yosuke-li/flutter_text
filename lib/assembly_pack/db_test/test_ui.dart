import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/test_add.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/sql_user.dart';
import 'package:flutter_text/utils/login_api.dart';

class TestDb extends StatefulWidget {
  @override
  _TestDbState createState() => _TestDbState();
}

class _TestDbState extends State<TestDb> {
  UserDbProvider provider = UserDbProvider();
  List<SqlUser> userList = [];

  LoginApi iCacheApi = LoginApi(); //todo interfaces 接口测试
  
  @override
  void initState() {
    super.initState();
    getUserList();
  }

  Future<void> getUserList() async {
    final List<SqlUser> list = await provider.getAllUser();
    final int counts = await provider.getTableCountsV2();
    
    final List<SqlUser> cache = await iCacheApi.getAllCache();
    setState(() {
      userList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sql 练习'),
      ),
      body: Container(
        child: RepaintBoundary(
          child: ListView(
            children: userList
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<bool>(
                              builder: (BuildContext context) => TestAdd(e))).then((bool? value) {
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
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute<bool>(builder: (BuildContext context) => TestAdd(SqlUser())))
              .then((bool? value) {
            if (value == true) {
              getUserList();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
