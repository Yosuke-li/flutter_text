import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:ffi' as ffi;
import 'package:call/call.dart';

///just use windows

typedef FuncVersion = ffi.Void Function();
typedef FuncDartV = void Function();


class DllTextPage extends StatefulWidget {
  @override
  _DllTextPageState createState() => _DllTextPageState();
}

class _DllTextPageState extends State<DllTextPage> {
  dynamic version;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _setVoid();
    }
  }

  void _setVoid() {
    var dll = getDyLibModule('assets/dll/HsFutuSystemInfo.dll');
    var getVersion = dll.lookupFunction<FuncVersion, FuncDartV>('hundsun_getversion');
    print(getVersion);
    version = getVersion;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('getVersion: $version'),
      ),
    );
  }
}
