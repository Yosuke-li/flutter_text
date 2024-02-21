import 'package:flutter/material.dart';

void function1(int a) {
  if (a == 3) {
    print('arg was 3');
  } else {
    print('arg was not 3');
  }
}

void function2(int a) => a == 3 ? print('arg was 3') : print('arg was not 3');

void findVolume(int breath, int height, {int length = 3}) {
  print('length = $length, breath = $breath, height = $height');
}



// This method should return the uppercase version of `str`
// or null if `str` is null.
String? upperCaseIt(String? str) {
  // Try conditionally accessing the `toUpperCase` method here.
  if (str != null && str.isNotEmpty) {
    return str.toUpperCase();
  } else {
    return str;
  }
}

// Assign this an empty List<double>:
final List<double> anEmptyListOfDouble = <double>[];

// Assign this an empty Set<String>:
final Set<String> anEmptySetOfString = <String>{};

// Assign this an empty Map of double to int:
//todo
final a = <double, int>{1: 2};
final Map<double, int> anEmptyMapOfDoublesToInts = Map<double, int>.from(<double, int>{1: 2});

class Ball{
  Ball();
}

List<Ball> list1 = List<Ball>.filled(5, Ball());

List<Ball> list2 = List<Ball>.generate(5, (int index) => index++ as dynamic);

/// 构造函数
class FirstTwoLetters {
  final String letterOne;
  final String letterTwo;

  // Create a constructor with an initializer list here:
  FirstTwoLetters(String word): assert(word.isEmpty == true),
        letterOne = word.substring(0, 1), letterTwo = word.substring(1, 2);
}

class b extends StatefulWidget {
  const b({super.key});

  @override
  State<b> createState() => _bState();
}

class _bState extends State<b> {



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class IntegerHolder {
  IntegerHolder();

  // Implement this factory constructor.
  factory IntegerHolder.fromList(List<int> list) {
    if (list.length == 1) {
      return IntegerSingle(list[0]);
    } else  if (list.length ==2) {
      return IntegerDouble(list[0], list[1]);
    } else {
      throw('null');
    }
  }
}

class IntegerSingle extends IntegerHolder {
  final int a;
  IntegerSingle(this.a);
}

class IntegerDouble extends IntegerHolder {
  final int a;
  final int b;
  IntegerDouble(this.a, this.b);
}

class MyTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing:100, children: [
      Chip(label: Text('I')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('really')),
      Chip(label: Text('need')),
      Chip(label: Text('a')),
      Chip(label: Text('job')),
    ]);
  }
}

Future<String> fetch() {
  return Future.delayed(const Duration(seconds: 2), () => '2334');
}
