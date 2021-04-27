import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_text/utils/isolate/isolate.dart';

void main() {
  test('isolate', () async {
    final String get = await load();
    print(get);
  });
}