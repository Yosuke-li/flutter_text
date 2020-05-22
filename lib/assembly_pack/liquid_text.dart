import 'package:flutter/cupertino.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/material.dart';

void main() => runApp(LiquidText());

class LiquidText extends StatelessWidget {
  Widget build(BuildContext context) {
    return LiquidDemo();
  }
}

class LiquidDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LiquidDemoState();
}

class LiquidDemoState extends State<LiquidDemo> {
  WaveType currentAnimate = WaveType.circularReveal;

  Widget build(BuildContext context) {
    return Container(
      child: LiquidSwipe(
        pages: <Container> [
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.pink,
          ),
          Container(
            color: Colors.teal,
          ),
        ],
        fullTransitionValue: 500,//滑动阀值
        enableSlideIcon: false, //显示右侧图标
        enableLoop: false,//循环切换
        positionSlideIcon: 0.5,//右侧图标的位置
        waveType: currentAnimate,//切换效果
        onPageChangeCallback: (page) => pageChangeCallback(page),//页面切换回调
        currentUpdateTypeCallback: (updateType) => updateTypeCallback(updateType),//当前页面更新回调
      ),
    );
  }
  pageChangeCallback(int page) {
    print(page);
  }
  updateTypeCallback(UpdateType updateType) {

  }
}