import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class ConnectWidget extends StatefulWidget {
  const ConnectWidget();

  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<ConnectWidget> {
  Stream<ConnectivityResult> connectChangeListener() async* {
    final Connectivity connectivity = Connectivity();
    await for (ConnectivityResult result
        in connectivity.onConnectivityChanged) {
      yield result;
    }
  }

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  bool? wifi;

  @override
  void initState() {
    super.initState();
    connectivitySubscription = connectChangeListener().listen(
      (ConnectivityResult connectivityResult) {
        if (!mounted) {
          return;
        }
        setState(() {
          wifi = connectivityResult == ConnectivityResult.wifi;
        });
      },
    );
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(wifi == false ? "有wifi" : "断wifi了"),
      ),
    );
  }
}
