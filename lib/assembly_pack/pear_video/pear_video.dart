import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_text/api/pear_video.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/widget/video_widget.dart';

class PearVideoFirstPage extends StatefulWidget {
  @override
  PearVideoFirstPageState createState() => PearVideoFirstPageState();
}

class PearVideoFirstPageState extends State<PearVideoFirstPage>
    with SingleTickerProviderStateMixin {
  SwiperController swperController = SwiperController(); //swiper组件
  ScrollController scroController = ScrollController(); //自动滑动title控制器
  Timer? timer; //自动滑动title
  int currentIndex = 0; //当前index
  int page = 1; //数据页数
  bool isShow = false; //是否显示页面
  List<Category> tabs = []; //底部栏
  List<HotList> hot = []; //swipe数据

  //title自动滚动
  void startTimer() {
    int time = 10000;
    timer = Timer.periodic(Duration(milliseconds: time), (Timer timer) {
      if (scroController.hasClients == false) {
        print('界面被销毁');
        return;
      }
      final double maxScrollExtent = scroController.position.maxScrollExtent;
      if (maxScrollExtent > 0) {
        scroController.animateTo(maxScrollExtent,
            duration: Duration(milliseconds: (time * 0.5).toInt()),
            curve: Curves.linear);
        Future.delayed(Duration(milliseconds: (time * 0.5).toInt()), () {
          if (scroController.hasClients == true) {
            scroController.animateTo(0,
                duration: Duration(milliseconds: (time * 0.5).toInt()),
                curve: Curves.linear);
          }
        });
      } else {
        print('不需要移动');
        timer.cancel();
      }
    });
  }

  //获取列表
  void getCategoryList() async {
    final result = await PearVideoApi().getCategoryList();
    setState(() {
      tabs = result;
    });
    getVideoList();
  }

  //获取视频信息
  void getVideoList({bool isLoadMore = false}) async {
    String? id = ArrayHelper.get(tabs, currentIndex)?.categoryId;
    final result = await PearVideoApi().getCategoryDataList(page, id!);
    if(result != null) {
      setState(() {
        page += 1;
        if (isLoadMore == false) {
          hot.clear();
          page = 1;
        }
        hot.addAll(result);
        isShow = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    getCategoryList();
  }

  //页面销毁
  @override
  void dispose() {
    scroController.dispose();
    swperController.dispose();
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: RepaintBoundary(
                  child: componentView(context),
                )
              ),
            ),
            bottomSheet: Container(
              height: 45,
              color: Colors.black,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                      getVideoList();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '${ArrayHelper.get(tabs, index)?.name ?? ''}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget componentView(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Swiper(
        loop: false,
        itemCount: hot.length,
        onIndexChanged: (int val) {
          if (val == hot.length - 1) {
            getVideoList(isLoadMore: true);
          }
        },
        controller: swperController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ArrayHelper.get(hot, index)?.videos != null
              ? Stack(
                  children: <Widget>[
                    VideoPlayerPage(
                      url: ArrayHelper.get(hot, index)
                          ?.videos
                          ?.url
                          ?.replaceAll('http:', 'https:'),
                      title: '${ArrayHelper.get(hot, index)?.name ?? '示例视频'}',
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      bottom: 80,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    ArrayHelper.get(hot, index)
                                        ?.nodeInfo
                                        ?.logoImg ?? ''),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 13),
                                child: Text(
                                  '${ArrayHelper.get(hot, index)?.nodeInfo?.name ?? ''}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: 150,
                            height: 30,
                            child: ListView(
                              controller: scroController,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                Text(
                                  '${ArrayHelper.get(hot, index)?.name ?? ''}',
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container();
        },
      ),
    );
  }
}
