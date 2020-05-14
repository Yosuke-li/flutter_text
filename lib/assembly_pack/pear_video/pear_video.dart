import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_text/api/pear_video.dart';
import 'package:flutter_text/model/pear_video.dart';
import 'package:flutter_text/utils/utils.dart';
import 'package:flutter_text/widget/video_widget.dart';

void main() => runApp(PearVideoFirstPage());

class PearVideoFirstPage extends StatefulWidget {
  PearVideoFirstPageState createState() => PearVideoFirstPageState();
}

class PearVideoFirstPageState extends State<PearVideoFirstPage>
    with SingleTickerProviderStateMixin {
  SwiperController swperController = SwiperController(); //swiper组件
  int currentIndex = 0; //当前index
  int page = 1; //数据页数
  bool isShow = false; //是否显示页面
  List<Category> tabs = []; //底部栏
  List<HotList> hot = []; //swipe数据

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
    String id = ArrayUtil.get(tabs, currentIndex).categoryId;
    final result = await PearVideoApi().getCategoryDataList(page, id);
    setState(() {
      page += 1;
      if (isLoadMore == false) {
        hot.clear();
        page = 1;
      }
      hot.addAll(result);
      isShow = true;
    });
    print(hot[0].videos.url);
  }

  void initState() {
    super.initState();
    getCategoryList();
  }

  Widget build(BuildContext context) {
    return isShow
        ? Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: componentView(context, tabs[currentIndex]),
              ),
            ),
            bottomSheet: Container(
              height: 60,
              color: Colors.black,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tabs?.length ?? 0,
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
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        '${ArrayUtil.get(tabs, index).name ?? ''}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget componentView(BuildContext context, Category item) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Swiper(
        loop: false,
        itemCount: hot?.length ?? 0,
        onIndexChanged: (val) {
          if (val == hot.length - 1) {
            getVideoList(isLoadMore: true);
          }
        },
        controller: swperController,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ArrayUtil.get(hot, index).videos.url != null
              ? VideoPlayerText(
                  url: ArrayUtil.get(hot, index)
                      .videos
                      .url
                      .replaceAll('http:', 'https:'),
                  title: '示例视频',
                  width: MediaQuery.of(context).size.width,
                )
              : Container();
        },
      ),
    );
  }
}
