import 'package:flutter/material.dart';
import 'package:flutter_text/widget/self_down_menu.dart';

class DownMenuWidget extends StatefulWidget {
  String select;
  List<String> menus;
  void Function(String value) selectFunc;

  DownMenuWidget({this.menus, this.selectFunc, this.select});

  @override
  _DownMenuWidget createState() => _DownMenuWidget();
}

class _DownMenuWidget extends State<DownMenuWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ACEDropdownButton(
        value: widget.select ?? '',
        isChecked: true,
        items: widget.menus?.map((e) {
          return ACEDropdownMenuItem(
              child: Text(e), value: e);
        })?.toList() ??
            [],
        onChanged: (value) {
          widget.selectFunc?.call(value);
        });
  }
}