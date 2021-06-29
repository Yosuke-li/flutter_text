import 'package:get/get.dart';

import 'state.dart';

class ChatRoomLogic extends GetxController {
  final ChatRoomState state = ChatRoomState();

  @override
  void onInit() {
    super.onInit();
    final map = Get.arguments;
    state.topic.value = map['topic'];
    update();
  }
}
