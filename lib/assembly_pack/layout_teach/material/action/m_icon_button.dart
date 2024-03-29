import 'package:flutter/material.dart';

class MIconButton extends StatelessWidget {
  const MIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('IconButton Sample')),
        body: const Center(
          child: IconButtonExample(),
        ),
      ),
    );
  }
}


class IconButtonExample extends StatefulWidget {
  const IconButtonExample({super.key});

  @override
  State<IconButtonExample> createState() => _IconButtonExampleState();
}

class _IconButtonExampleState extends State<IconButtonExample> {
  int _volume = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.volume_up),
          tooltip: 'Increase volume by 10',
          onPressed: () {
            setState(() {
              _volume += 10;
            });
          },
        ),
        Text('Volume : $_volume'),
      ],
    );
  }
}
