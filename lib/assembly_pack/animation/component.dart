import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/animation/animated_container.dart';
import 'package:flutter_text/assembly_pack/animation/animated_cross_fade.dart';
import 'package:flutter_text/assembly_pack/neumorphic/calculator/calculator_sample.dart';
import 'package:flutter_text/assembly_pack/neumorphic/clock.dart';
import 'package:flutter_text/assembly_pack/neumorphic/example_one.dart';
import 'package:flutter_text/assembly_pack/neumorphic/example_two.dart';
import 'package:flutter_text/assembly_pack/neumorphic/neumorphic_example.dart';
import 'package:flutter_text/model/AComponent.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/utils.dart';

import 'animated_physical_page.dart';
import 'circle_light.dart';
import 'cupetino.dart';

class AnimaComponentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnimaComponentPageState();
}

class AnimaComponentPageState extends State<AnimaComponentPage> {
  List<PageModel> _page = [];

  @override
  void initState() {
    super.initState();
    _page = [
      PageModel()
        ..name = 'AnimatedContainerPage'
        ..pageUrl = AnimatedContainerPage(),
      PageModel()
        ..name = 'AnimatedCrossFadePage'
        ..pageUrl = AnimatedCrossFadePage(),
      PageModel()
        ..name = 'circle_light'
        ..pageUrl = CircleLightPage(),
      PageModel()
        ..name = 'AnimatedPhysicalPage'
        ..pageUrl = AnimatedPhysicalPage(),
      PageModel()
        ..name = 'NeumorphicExamplePage'
        ..pageUrl = NeumorphicExamplePage(),
      PageModel()
        ..name = 'ExampleOnePage'
        ..pageUrl = ExampleOnePage(),
      PageModel()
        ..name = 'ExampleTwoPage'
        ..pageUrl = ExampleTwoPage(),
      PageModel()
        ..name = 'ClockAlarmPage'
        ..pageUrl = ClockAlarmPage(),
      PageModel()
        ..name = 'CalculatorSample'
        ..pageUrl = CalculatorSample(),
      PageModel()
        ..name = 'CupertinoContextMenuPage'
        ..pageUrl = CupertinoContextMenuPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('anmiation_list'),
      ),
      body: Center(
        child: GridView.custom(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          childrenDelegate: SliverChildBuilderDelegate((context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ArrayHelper.get(_page, index).pageUrl),
                );
              },
              child: Container(
                decoration: BoxDecoration(border: Border.all(width: 1)),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('${ArrayHelper.get(_page, index).name}'),
              ),
            );
          }, childCount: _page.length ?? 0),
        ),
      ),
    );
  }
}
