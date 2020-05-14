import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_text/api/pear_video.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:flutter_text/widget/video_widget.dart';
import 'package:video_player/video_player.dart';

import 'componet_list.dart';

void main() => runApp(PearVideoFirstPage());

class PearVideoFirstPage extends StatefulWidget {
  PearVideoFirstPageState createState() => PearVideoFirstPageState();
}

class PearVideoFirstPageState extends State<PearVideoFirstPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int currentIndex = 0;
  List<Category> tabs = [];
  List<Widget> sub = [];

  void _getCategoryList() async {
    final result = await PearVideoApi().getCategoryList();
    setState(() {
      tabs = result;
    });
    tabController = TabController(length: result.length, vsync: this)
      ..addListener(() {
        setState(() {
          currentIndex = tabController.index;
        });
      });
  }

  void initState() {
    super.initState();
    _getCategoryList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: TabBarView(
            children: tabs.map((item) => componentView(item)).toList(),
            controller: tabController,
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        child: TabBar(
          labelColor: const Color(0xff003d95),
          unselectedLabelColor: const Color(0x80003d95),
          indicatorColor: const Color(0x00999999),
          controller: tabController,
          tabs: tabs
              .map(
                (item) => Container(
              child: Text('${item.name}'),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
