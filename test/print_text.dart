import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('print with color', () {
    //\x1B[35m {内容} \x1B[0m 打印带颜色
    print('\x1B[35m 紫色hello world \x1B[0m');
    print('\x1B[31m 红色hello world \x1B[0m');
    print('\x1B[1;35m 紫色粗体hello world \x1B[0m');
    print('\x1B[1m 粗体 \x1B[0m');
    print('\x1B[4m 下划线hello world \x1B[0m');
  });

  test('random', () {
    final index = Random().nextInt(20);
    print(index);
  });

  test('patterns 解构函数', () {
    var a = {'b', 10};
    

  });
}