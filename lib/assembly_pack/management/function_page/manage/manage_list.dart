import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/widget/management/widget/common_form.dart';

class ManageListPage extends StatefulWidget {
  @override
  _ManageListPageState createState() => _ManageListPageState();
}

class _ManageListPageState extends State<ManageListPage> {
  UserDbProvider provider = UserDbProvider();
  List<User> users = [];


  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final List<User> list = await provider.getAllUser();
    final int counts = await provider.getTableCountsV2();
    print('counts: $counts');
    setState(() {
      users = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: [
          CommonForm<User>(
            columns: [
              FormColumn<User>(
                  title: 'id',
                  builder: (_, v) => Container(
                    child: Text('${v.id ?? ''}'),
                  ),
              ),
              FormColumn<User>(
                  title: '姓名',
                  builder: (_, v) => Container(
                    child: Text('${v.name ?? ''}'),
                  ),
              ),
              FormColumn<User>(
                  title: '详情',
                  builder: (_, v) => Container(
                    child: Text('${v.desc ?? ''}'),
                  ),
              ),
              FormColumn<User>(
                  title: '操作',
                  builder: (_, v) => GestureDetector(
                    child: const Icon(Icons.edit),
                  ),
              ),
            ],
            values: users,
          )
        ],
      ),
    );
  }
}