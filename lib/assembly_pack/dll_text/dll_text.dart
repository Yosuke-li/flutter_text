import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ffi' as ffi;
import 'package:call/call.dart';
import 'package:flutter_text/utils/log_utils.dart';

///just use windows

typedef FuncVersion = ffi.Int32 Function();
typedef FuncDartV = int Function();


class DllTextPage extends StatefulWidget {
  @override
  _DllTextPageState createState() => _DllTextPageState();
}

class _DllTextPageState extends State<DllTextPage> {
  Function() version;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _setVoid();
    }
  }

  void _setVoid() {
    var dll = getDyLibModule('assets/dll/HsFutuSystemInfo.dll');
    Log.info(dll);
    var getVersion = dll.lookupFunction<FuncVersion, FuncDartV>('hundsun_getversion');
    Log.info('version: ${getVersion()}');
    version = getVersion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dll 测试'),
      ),
      body: Center(
        child: Text('getVersion: ${version()}'),
      ),
    );
  }
}
