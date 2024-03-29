import 'package:flutter/material.dart';

class MCard extends StatelessWidget {
  const MCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Card Examples')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(child: _SampleCard(cardName: 'Elevated Card')),
              Card.filled(child: _SampleCard(cardName: 'Filled Card')),
              Card.outlined(child: _SampleCard(cardName: 'Outlined Card')),
            ],
          ),
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}