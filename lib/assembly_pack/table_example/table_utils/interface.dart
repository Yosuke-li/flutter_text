import 'package:self_utils/init.dart';

abstract class TableApi<T> {
  late List<T> allKey;

  void onListener(dynamic msgContent);

  List<T> getData();

  List<FormColumn<T>> setColumns();
}