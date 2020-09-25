import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/database/user_db_provider.dart';
import 'package:flutter_text/model/db_bean.dart';

void main() => runApp(TestDb());

class TestDb extends StatefulWidget {
  _TestDbState createState() => _TestDbState();
}

class _TestDbState extends State<TestDb> {
  UserDbProvider provider = UserDbProvider();
  List<User> userList = [];

  void initState() {
    super.initState();
    getUserList();
  }

  Future<void> getUserList() async {
    final list = await provider.getAllUser();
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
                  (e) => Container(
                    child: Text(e.name),
                  ),
                )
                ?.toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child:Icon(Icons.add),
      ),
    );
  }
}
