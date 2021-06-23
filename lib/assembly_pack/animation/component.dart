import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/animation/animated_container.dart';
import 'package:flutter_text/assembly_pack/animation/animated_cross_fade.dart';
import 'package:flutter_text/model/AComponent.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/utils/utils.dart';

import 'circle_light.dart';

void main() => runApp(AnimaComponentPage());

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
        ..pageUrl = CircleLightPage()
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
