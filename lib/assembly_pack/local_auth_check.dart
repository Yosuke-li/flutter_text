import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthCheck extends StatefulWidget {
  @override
  _localAuthCheckState createState() => _localAuthCheckState();
}

class _localAuthCheckState extends State<LocalAuthCheck> {
  /// 本地认证框架
  final LocalAuthentication auth = LocalAuthentication();

  /// 是否有可用的生物识别技术
  bool _canCheckBiometrics;

  /// 生物识别技术列表
  List<BiometricType> _availableBiometrics;

  /// 识别结果
  String _authorized = '验证失败';

  bool _isAuthenticating = false;

  /// 检查是否有可用的生物识别技术
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  /// 获取生物识别技术列表
  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  /// 生物识别
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: '扫描指纹进行身份验证',
          useErrorDialogs: true,
          stickyAuth: false);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? '验证通过' : '验证失败';
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('插件的示例应用程序'),
      ),
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('是否有可用的生物识别技术: $_canCheckBiometrics\n'),
                RaisedButton(
                  child: const Text('检查生物识别技术'),
                  onPressed: _checkBiometrics,
                ),
                Text('可用的生物识别技术: $_availableBiometrics\n'),
                RaisedButton(
                  child: const Text('获取可用的生物识别技术'),
                  onPressed: _getAvailableBiometrics,
                ),
                Text('状态: $_authorized\n'),
                RaisedButton(
                  child: const Text('验证'),
                  onPressed: _authenticate,
                )
              ])),
    ));
  }
}
