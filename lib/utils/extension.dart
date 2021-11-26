import 'datetime_utils.dart';

//拓展方法
extension GenerateDate on num {
  String get getLocalTimeStamp {
    return DateTimeHelper.datetimeFormat(this, 'yyyy-MM-dd');
  }
}