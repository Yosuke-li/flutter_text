import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/layout_teach/basic/future.dart';
import 'package:flutter_text/assembly_pack/layout_teach/basic/image.dart';

import 'switch.dart';
import 'text.dart';

class BasicTypePage extends StatefulWidget {
  const BasicTypePage({super.key});

  @override
  State<BasicTypePage> createState() => _BasicTypePageState();
}

class _BasicTypePageState extends State<BasicTypePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            BasicTextWidget(),
            BasicFutureWidget(),
            BasicSwitchWidget(),
            BasicImgPage(),
          ],
        ),
      ),
    );
  }
}
