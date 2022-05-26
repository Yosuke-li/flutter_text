import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurpertinoViewPage extends StatelessWidget {
  final List<Color> data = [
    Colors.orange[50]!,
    Colors.orange[100]!,
    Colors.orange[200]!,
    Colors.orange[300]!,
    Colors.orange[400]!,
    Colors.orange[500]!,
    Colors.orange[600]!,
    Colors.orange[700]!,
    Colors.orange[800]!,
    Colors.orange[900]!,
    Colors.red[50]!,
    Colors.red[100]!,
    Colors.red[200]!,
    Colors.red[300]!,
    Colors.red[400]!,
    Colors.red[500]!,
    Colors.red[600]!,
    Colors.red[700]!,
    Colors.red[800]!,
    Colors.red[900]!,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              padding: const EdgeInsetsDirectional.all(10),
              trailing: const Icon(
                CupertinoIcons.share,
                size: 25,
              ),
              backgroundColor: Colors.white,
              // middle: Text('张风捷特烈'),
              largeTitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Icon(
                    Icons.ac_unit,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('title'),
                  ),
                  Icon(Icons.ac_unit, size: 20),
                ],
              ),
            ),
            _buildSliverList()
          ],
        ),
      ),
    );
  }

  Widget _buildSliverList() => SliverPrototypeExtentList(
    prototypeItem: Container(
      height: 40,
    ),
    delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
          alignment: Alignment.center,
          width: 100,
          height: 60,
          color: data[index],
          child: Text(
            colorString(data[index]),
            style: const TextStyle(color: Colors.white, shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2)
            ]),
          ),
        ),
        childCount: data.length),
  );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}