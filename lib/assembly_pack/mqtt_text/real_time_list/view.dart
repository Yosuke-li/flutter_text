import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/mqtt_text/real_time_list/real_list.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class RealTimeListPage extends StatefulWidget {
  @override
  _RealTimeListPageState createState() => _RealTimeListPageState();
}

class _RealTimeListPageState extends State<RealTimeListPage> {
  final RealTimeListLogic logic = Get.put(RealTimeListLogic());
  final RealTimeListState state = Get.find<RealTimeListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => RealListWidget(realDatas: state.realDatas.value),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            child: const Icon(Icons.add),
            onPressed: () {
              logic.publish('123');
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<RealTimeListLogic>();
    state.voidCallback?.call();
    super.dispose();
  }
}
