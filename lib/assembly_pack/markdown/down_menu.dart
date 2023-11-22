import 'package:flutter/material.dart';
import 'package:self_utils/utils/screen.dart';

class DownMenuWidget<T> extends StatefulWidget {
  T select;
  List<T> menus;
  void Function(T value) selectFunc;

  DownMenuWidget({required this.menus, required this.selectFunc, required this.select});

  @override
  _DownMenuWidget<T> createState() => _DownMenuWidget<T>();
}

class _DownMenuWidget<T> extends State<DownMenuWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
          value: widget.select ?? widget.menus[0],
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, size: screenUtil.adaptive(24),),
          items: widget.menus.map((e) {
                return DropdownMenuItem<T>(child: Text('$e'), value: e);
              }).toList(),
          onChanged: (T? value) {
            if (value !=null) {
              widget.selectFunc.call(value);
            }
          },
      ),
    );
  }
}
