import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart'; //用于转String
import 'package:call/call.dart';
import 'package:self_utils/utils/log_utils.dart';

///just use windows
typedef FuncVersion = ffi.Float Function(ffi.Float x, ffi.Float y);
typedef FuncDartV = double Function(double x, double y);

typedef FuncString = ffi.Pointer<ffi.Int8> Function();
typedef FuncS = ffi.Pointer<ffi.Int8> Function();

typedef FuncStrLength = ffi.Int32 Function(ffi.Pointer<ffi.Int8> x);
typedef FuncStrL = int Function(ffi.Pointer<ffi.Int8> x);


class DllTextPage extends StatefulWidget {
  @override
  _DllTextPageState createState() => _DllTextPageState();
}

class _DllTextPageState extends State<DllTextPage> {
  ffi.Pointer<ffi.Int8>? helloFunc;
  Function(double x, double y)? addFunc;
  Function(ffi.Pointer<ffi.Int8>)? strLengthFunc;

  static const String value = 'Hello world';

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _setVoid();
    }
  }

  void _setVoid() {
    ffi.DynamicLibrary dll = getDyLibModule('assets/dll/MyDLL.dll');
    Log.info(dll);
    var add = dll.lookupFunction<FuncVersion, FuncDartV>('Add');
    FuncString hello = dll.lookupFunction<FuncString, FuncS>('Hello');
    var strLength = dll.lookupFunction<FuncStrLength, FuncStrL>('StrLength');
    addFunc = add;
    helloFunc = hello();
    strLengthFunc = strLength;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dll 测试'),
      ),
      body: Center(
        child: Platform.isWindows == true ? Column(
          children: [
            Text('add: ${addFunc!(1,5)}'),
            Text('hello: ${helloFunc?.cast<Utf8>().toDartString()}'),
            Text('strLengthFunc: ${strLengthFunc!(value.toNativeUtf8().cast<ffi.Int8>())}')
          ],
        ) : Container(
          child: const Text('android 上无法使用 dll'),
        ),
      ),
    );
  }
}
