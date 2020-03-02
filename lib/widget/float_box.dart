import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatBox extends StatefulWidget {
  _FloatBoxState createState() => _FloatBoxState();
}

class _FloatBoxState extends State<FloatBox> {
  Offset offset = Offset(10, kToolbarHeight + 100);

  Offset _calOffset(Size size, Offset offset, Offset nextOffset) {
    double dx = 0;
    if (offset.dx + nextOffset.dx <= 0) {
      dx = 0;
    } else if (offset.dx + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = offset.dx + nextOffset.dx;
    }
    double dy = 0;
    if (offset.dy + nextOffset.dy >= (size.height - 100)) {
      dy = size.height - 100;
    } else if (offset.dy + nextOffset.dy <= kToolbarHeight) {
      dy = kToolbarHeight;
    } else {
      dy = offset.dy + nextOffset.dy;
    }
    return Offset(
      dx,
      dy,
    );
  }

  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: Brightness.dark,
        ),
      ),
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
          onPanUpdate: (detail) {
            setState(() {
              offset =
                  _calOffset(MediaQuery.of(context).size, offset, detail.delta);
            });
            print(offset);
            print(MediaQuery.of(context).size.width);
          },
          onTap: () {},
          onPanEnd: (detail) {},
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
              border: Border.all(width: 1, color: Colors.lightBlue),
              borderRadius: BorderRadius.all(Radius.circular(33.0)),
            ),
            child: Icon(Icons.add,
                color: Colors.white, size: 30),
          ),
        ),
      ),
    );
  }
}

