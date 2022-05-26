import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/sql_user.dart';
import 'package:flutter_text/widget/management/widget/common_form.dart';

class ManageListPage extends StatefulWidget {
  @override
  _ManageListPageState createState() => _ManageListPageState();
}

class _ManageListPageState extends State<ManageListPage> {
  UserDbProvider provider = UserDbProvider();
  List<SqlUser> users = [];


  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final List<SqlUser> list = await provider.getAllUser();
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
          CommonForm<SqlUser>(
            height: 300,
            columns: [
              FormColumn<SqlUser>(
                  title: const Text('id'),
                  builder: (_, v) => Container(
                    child: Text('${v.id ?? ''}'),
                  ),
              ),
              FormColumn<SqlUser>(
                  title: const Text('姓名'),
                  builder: (_, v) => Container(
                    child: Text('${v.name ?? ''}'),
                  ),
              ),
              FormColumn<SqlUser>(
                  title: const Text('详情'),
                  builder: (_, v) => Container(
                    child: Text('${v.desc ?? ''}'),
                  ),
              ),
              FormColumn<SqlUser>(
                  title: const Text('操作'),
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