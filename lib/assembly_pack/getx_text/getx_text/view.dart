import 'package:flutter/material.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:get/get.dart';

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
        child: Obx(() => Text('点击了：${state.count.value ?? 0}')),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.arrow_back),
            onPressed: () {
              NavigatorUtils.pop(context, results: 'back');
            },
          ),
          FloatingActionButton(
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
