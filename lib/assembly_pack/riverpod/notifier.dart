import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';

import '../../init.dart';

final countProvider = StateNotifierProvider((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}

final loginProvider = ChangeNotifierProvider((ref) {
  return LoginUser();
});

class LoginUser extends ChangeNotifier{

  User? user;

  void set(User value) {
    user = value;
    notifyListeners();
  }

  User? get() => user;

}
