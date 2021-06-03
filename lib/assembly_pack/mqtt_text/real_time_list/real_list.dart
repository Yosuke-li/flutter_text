import 'package:flutter/material.dart';

class RealListWidget extends StatefulWidget {
  List<String> realDatas;

  RealListWidget({this.realDatas});

  @override
  _RealListWidgetState createState() => _RealListWidgetState();
}

class _RealListWidgetState extends State<RealListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: widget.realDatas
          ?.map(
            (e) => Container(
          child: Text(e),
        ),
      )
          ?.toList() ??
          [],
    );
  }
}