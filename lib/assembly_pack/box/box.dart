import 'package:flutter/material.dart';

class BoxPage extends StatefulWidget {
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<BoxPage> {

  Widget _BoxWidget() {
    return Container();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('box合集'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('SizeBox'),
            SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('点击'),
              ),
            ),
            const SizedBox(
              height: 30,
              width: 30,
            ),
            SizedBox.shrink(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('点击'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
