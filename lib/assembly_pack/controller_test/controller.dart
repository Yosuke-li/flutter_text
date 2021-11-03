import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/datetime_utils.dart';

class Controller extends ChangeNotifier {
  DateTime currentDate = DateTimeHelper.getNow();

  List<int> active = [];

  void goPreviousDay() {
    currentDate = currentDate.add(const Duration(days: -1));
    notifyListeners();
  }

  void goNextDay() {
    currentDate = currentDate.add(const Duration(days: 1));
    notifyListeners();
  }

  @override
  void dispose() {
    active = [];
    super.dispose();
  }
}