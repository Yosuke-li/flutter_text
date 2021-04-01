import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/db_test/user_db_provider.dart';
import 'package:flutter_text/model/db_user.dart';
import 'package:flutter_text/utils/date_format.dart';
import 'package:flutter_text/widget/api_call_back.dart';
import 'package:flutter_text/widget/skeleton.dart';

class SkeletonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('骨架屏 test'),
      ),
      body: SkeletonPage(),
    );
  }
}

class SkeletonPage extends StatefulWidget {
  @override
  SkeletonPageState createState() => SkeletonPageState();
}

class SkeletonPageState extends State<SkeletonPage> {
  UserDbProvider provider = UserDbProvider();
  List<User> user = <User>[];
  SkeletonManager<User> skeletonManager;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      final SkeletonManager<User> r =
          SkeletonManager<User>((List<User> items) async {
        await loadingCallback(() => Future<void>.delayed(const Duration(seconds: 2)));
        final List<User> list = await provider.getAllUser();
        setState(() {
          user = list;
        });
      });
      final int count = await provider.getTableCountsV2();
      setState(() {
        skeletonManager = r;
        for (int i = 0; i < count; i++) {
          user.add(User());
        }
      });
    } catch (error, stack) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: user?.map((User e) {
            return SkeletonItem<User>(
              source: e,
              skeletonManager: skeletonManager,
              status: e.id != null
                  ? SkeletonStatus.loadDone
                  : SkeletonStatus.waitLoad,
              skeleton: (BuildContext context) => Container(
                child: Text('1'),
              ),
              child: (BuildContext context) => Container(
                child: Text(e.name),
              ),
            );
          })?.toList() ??
          [],
    );
  }
}
