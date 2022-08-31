import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:self_utils/utils/helpers/f_test.dart';
import 'package:self_utils/utils/mixin/test.dart';

void main() {
  test('mixin', () async {
    B a = B();
    a.eat();
  });

  test('f_test', () async {
    final test = FunctionTest();
    print(test.a);
    test.setA = 10;
    print(test.a);
  });

  test('completer', () async {
    final completer = Completer<void>();
    print('1');
    completer.complete(
      Future<void>.delayed(const Duration(seconds: 1), () {
        print('2');
      }),
    );
    print('3');
    await completer.future;
    print('4');
  });
}
