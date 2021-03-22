import 'package:flutter/material.dart';

//数组有关的方法
class ArrayHelper {
  static T get<T>(List<T> list, int index) {
    assert(index != null);
    if (list != null && list.isNotEmpty == true) {
      return list[index];
    } else {
      return null;
    }
  }

  static List<int> unique_int(List<int> list) {
    return unique<int>(listData: list, key: (int item) => item);
  }

  //去重_泛型
  static List<T> unique<T>(
      {@required List<T> listData, @required dynamic Function(T value) key}) {
    if (listData?.isNotEmpty == true) {
      final Map<dynamic, List<T>> maps = Map<dynamic, List<T>>.fromIterable(
          listData,
          key: (dynamic key) => key(key as T),
          value: (dynamic item) => listData
              .where((T element) => key(element) == key(item))
              .toList());
      final List<T> list = maps.values
          ?.map((List<T> e) => e.isNotEmpty == true ? e.first : null)
          ?.toList();
      return list..removeWhere((T element) => element == null);
    } else
      return <T>[];
  }
}
