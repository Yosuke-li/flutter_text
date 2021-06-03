import 'package:flutter/material.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:get/get.dart';

import 'down_menu.dart';
import 'logic.dart';
import 'state.dart';

class GetxTextPage extends StatefulWidget {
  @override
  _GetxTextPageState createState() => _GetxTextPageState();
}

class _GetxTextPageState extends State<GetxTextPage> {
  final GetxTextLogic logic = Get.put(GetxTextLogic());
  final GetxTextState state = Get.find<GetxTextLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Obx(() => Column(
          children: [
            Text('点击了：${state.count.value ?? 0}'),
            DownMenuWidget(
              select: state.select.value,
              menus: state.servers,
              selectFunc: (String value) {
                state.select.value = value;
              },
            ),
          ],
        ),),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'back',
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              NavigatorUtils.pop(context, results: '${state.count.value ?? 0}');
            },
          ),
          Container(
            width: screenUtil.adaptive(25),
          ),
          FloatingActionButton(
            heroTag: 'add',
            child: const Icon(Icons.add),
            onPressed: () {
              logic.increase();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<GetxTextLogic>();
    super.dispose();
  }
}
