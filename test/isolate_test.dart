import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text/utils/isolate/isolate.dart';

void main() {
  test('isolate', () async {
    final String get = await load();
    print(get);
  });

  test('isolate2', () async {
    final dynamic get2 = await loadT();
    print(get2);
  });

  test('isolate3', () async {
    final numbs = [10000, 20000, 30000, 40000];
    print('1');
    await for (final data in sendAndReceive(numbs)) {
      print('data');
      print(data.toString());
    }
    print('2');
  });
}