import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_text/init.dart';

class ExampleOnePage extends StatefulWidget {
  @override
  _ExampleOneState createState() => _ExampleOneState();
}

class _ExampleOneState extends State<ExampleOnePage> {
  bool check1 = false;
  String? _groupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('neumorphic_page'),
      ),
      body: NeumorphicBackground(
        child: RepaintBoundary(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              NeumorphicButton(
                padding: const EdgeInsets.all(18.0),
                onPressed: () {},
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                ),
                child: const Icon(
                  Icons.skip_previous,
                ),
              ),
              NeumorphicText(
                'Flutter',
                style: const NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  depth: 2,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicIcon(
                    Icons.ten_k,
                    size: 80,
                    style: const NeumorphicStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.ten_k,
                    size: 80,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              NeumorphicCheckbox(
                value: check1,
                onChanged: (value) {
                  setState(() {
                    check1 = value;
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: NeumorphicProgress(
                  percent: 0.3,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              NeumorphicRadio(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text("1"),
                  ),
                ),
                value: 1,
                groupValue: _groupValue,
                onChanged: (value) {
                  setState(() {
                    _groupValue = value.toString();
                  });
                },
              ),
              const SizedBox(
                height: 30,
              ),
              NeumorphicIndicator(
                percent: 0.8,
                padding: const EdgeInsets.all(3),
                orientation: NeumorphicIndicatorOrientation.horizontal,
                height: 20,
                style: IndicatorStyle(
                  accent: Colors.grey[100],
                  variant: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
