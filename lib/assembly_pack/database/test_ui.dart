import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/database/test_add.dart';
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
                ?.map((e) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TestAdd(e)))
                            .then((value) {
                          if (value == true) {
                            getUserList();
                          }
                        });
                      },
                      child: Container(
                        height: 30,
                        child: Text('${e.name} ${e.desc}'),
                      ),
                    ))
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
