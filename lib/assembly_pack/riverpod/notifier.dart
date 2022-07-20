import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';

final countProvider = StateNotifierProvider((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

class LoginUser extends StateNotifier<User> {
  LoginUser(User state) : super(state);

}
