import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReorderablePage extends StatefulWidget {
  @override
  _ReorderableState createState() => _ReorderableState();
}

class _ReorderableState extends State<ReorderablePage> {
  final List<Color> data = [
    Colors.yellow[50]!,
    Colors.yellow[100]!,
    Colors.yellow[200]!,
    Colors.yellow[300]!,
    Colors.yellow[400]!,
    Colors.yellow[500]!,
    Colors.yellow[600]!,
    Colors.yellow[700]!,
    Colors.yellow[800]!,
    Colors.yellow[900]!,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('reorderableListView'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: ReorderableListView(
                padding: const EdgeInsets.all(10),
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  setState(() {
                    final element = data.removeAt(oldIndex);
                    data.insert(newIndex, element);
                  });
                },
                children: data.map((e) => _buildItem(e)).toList(),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              child: ReorderableListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10),
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }

                  setState(() {
                    final element = data.removeAt(oldIndex);
                    data.insert(newIndex, element);
                  });
                },
                children: data.map((e) => _buildItem(e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";

  Widget _buildItem(Color color) {
    return Container(
      key: ValueKey(color),
      alignment: Alignment.center,
      height: 50,
      color: color,
      child: Text(
        colorString(color),
        style: TextStyle(color: Colors.white, shadows: [
          Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
        ]),
      ),
    );
  }
}
