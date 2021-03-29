import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(new MyApp());

class Model {
  int id;
  String img;
  String title;
  int price;
  String protuct_img;
  String show;
  String peisong;
  bool is_collection;

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Study',
      home: TabBarDemo(),
    );
  }
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: [
              Tab(text: '美食'),
              Tab(text: '美食'),
              Tab(text: '美食'),
              Tab(text: '美食'),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            RandomWords(),
            const Icon(Icons.directions_transit),
            const Icon(Icons.directions_bike),
            const Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

//list区
class RandomWordsState extends State<RandomWords> {
  @override
  List<Model> _shopList;
  int _page = 1;
  bool isLoading = false; //是否正在加载数据
  ScrollController _scrollController = new ScrollController();

  //初始化数据
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels  ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
    _shopList = [
      Model()
        ..id = 1
        ..title = '牛油果'
        ..price = 45
        ..img = 'images/timg.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = false,

      Model()
        ..id = 2
        ..title = '百香果'
        ..price = 10
        ..img = 'images/timg2.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg2.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = false,

      Model()
        ..id = 3
        ..title = '花生'
        ..price = 100
        ..img = 'images/timg3.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg3.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = false,

      Model()
        ..id = 4
        ..title = '牛油果'
        ..price = 50
        ..img = 'images/timg.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = false,

      Model()
        ..id = 5
        ..title = '牛油果'
        ..price = 411
        ..img = 'images/timg2.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg2.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = true,

      Model()
        ..id = 6
        ..title = '牛油果'
        ..price = 600
        ..img = 'images/timg.jpg'
        ..peisong = '100'
        ..protuct_img = 'images/timg.jpg'
        ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
        ..is_collection = false,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: _buildSuggestions(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      itemCount: _shopList?.length,
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        return pageWidget(i);
      },
    );
  }

  Future<Null> _onRefresh() async {
    await Future<void>.delayed(const Duration(seconds: 3), () {
      print('refresh');
      setState(() {
        _shopList = [
          Model()
            ..id = 1
            ..title = '牛油果'
            ..price = 45
            ..img = 'images/timg.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = false,

          Model()
            ..id = 2
            ..title = '百香果'
            ..price = 10
            ..img = 'images/timg2.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg2.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = false,

          Model()
            ..id = 3
            ..title = '花生'
            ..price = 100
            ..img = 'images/timg3.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg3.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = false,

          Model()
            ..id = 4
            ..title = '牛油果'
            ..price = 50
            ..img = 'images/timg.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = false,

          Model()
            ..id = 5
            ..title = '牛油果'
            ..price = 411
            ..img = 'images/timg2.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg2.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = true,

          Model()
            ..id = 6
            ..title = '牛油果'
            ..price = 600
            ..img = 'images/timg.jpg'
            ..peisong = '100'
            ..protuct_img = 'images/timg.jpg'
            ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
            ..is_collection = false,
        ];
      });
    });
  }

  //模板
  Widget pageWidget(i) {
    return Column(
        children: <Widget>[
          Row(
              children: <Widget>[
                Container(
                  child: new Image(
                    image: AssetImage('${_shopList[i]?.img}'),
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  width: 150,
                  height: 150,
                  padding: new EdgeInsets.only(top: 10, bottom: 10),
                  margin: new EdgeInsets.only(right: 10, left: 10),
                ),
                Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: new Text(
                              '${_shopList[i]?.title}',
                              style: TextStyle(
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Text('￥${_shopList[i]?.price}'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                            child:  const Text('当日午餐',
                              style: TextStyle(
                                  color: Color.fromARGB(100, 0, 0, 128)
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                            child: const Text('当日晚餐',
                                style: TextStyle(
                                    color: Color.fromRGBO(96, 96, 96, 0.5)
                                )
                            ),
                          ),
                          Container(
                            padding:const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                            child: const Text('当日夜宵',
                                style: TextStyle(
                                    color: Color.fromRGBO(96, 96, 96, 0.5)
                                )
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          child: Text(
                              '${_shopList[i]?.is_collection}' == 'false' ? '收藏': '已收藏'
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) => new SecondScreen(view: _shopList[i])
                                )
                            ).then((onValue) {
                              setState(() {
                                _shopList.map((item){
                                  if ( item == _shopList[i] )
                                    item.is_collection = onValue == null ? false : onValue;
                                  return item;
                                }).toList();
                              });
                            });
                          },
                        ),
                      ),
                      new Row(
                        children: <Widget>[
                          new Container(
                            padding: new EdgeInsets.only(right: 20),
                            child: new Text('用礼金兑换', style: new TextStyle(color: Colors.redAccent),),
                          ),
                          new Container(
                            child: new Text('送给TA', style: new TextStyle(color: Colors.white),),
                            alignment: Alignment(0, 0),
                            color: Colors.pink,
                            width: 50,
                            height: 25,
                          ),
                        ],
                      ),
                    ]
                )
              ]
          )
        ]
    );
  }

  Future<Null> _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 2), () {
        print('加载更多');
        setState(() {
          _shopList.addAll(
              [
                Model()
                  ..id = 1
                  ..title = '牛油果'
                  ..price = 45
                  ..img = 'images/timg.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = false,

                Model()
                  ..id = 2
                  ..title = '百香果'
                  ..price = 10
                  ..img = 'images/timg2.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg2.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = false,

                Model()
                  ..id = 3
                  ..title = '花生'
                  ..price = 100
                  ..img = 'images/timg3.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg3.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = false,

                Model()
                  ..id = 4
                  ..title = '牛油果'
                  ..price = 50
                  ..img = 'images/timg.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = false,

                Model()
                  ..id = 5
                  ..title = '牛油果'
                  ..price = 411
                  ..img = 'images/timg2.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg2.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = true,

                Model()
                  ..id = 6
                  ..title = '牛油果'
                  ..price = 600
                  ..img = 'images/timg.jpg'
                  ..peisong = '100'
                  ..protuct_img = 'images/timg.jpg'
                  ..show = '精选日本仙台和牛，烧制三分熟切片，淋秘制酱汁，配以新泻县鱼诏产越光米，鲜香嫩滑回味留甘，限量供应'
                  ..is_collection = false,
              ]
          );
          _page++;
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }
}

//第二个页面
class SecondScreen extends StatefulWidget {
  @override
  final Model view; // 用来储存传递过来的值
  SecondScreen({this.view}); // 本页面的构造器，接收传递过来的参数

  _SecondContent createState() => new _SecondContent();

}

//第二个页面内容
class _SecondContent extends State<SecondScreen> {
  bool alreadySaved = false;

  @override
  void initState() {
    super.initState();
    alreadySaved = widget.view?.is_collection;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.view?.title),
        backgroundColor: Colors.brown,
      ),
      body: new Center(
        child: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Row(
                    children: <Widget>[
                      new Container(
                        padding: new EdgeInsets.only(right: 20),
                        child: new Image(
                          image: AssetImage(widget.view?.img),
                          width: 150,
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                      new Column(
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Container(
                                  padding: new EdgeInsets.only(right: 15),
                                  child: new Text(
                                    '单价',
                                    style: new TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(255, 0, 0, 1)
                                    ),
                                  ),
                                ),
                                new Container(
                                  child: new Text(
                                    '￥${widget.view?.price}',
                                    style: new TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(255, 0, 0, 1)
                                    ),),
                                  padding: new EdgeInsets.only(right: 20),
                                ),
                                new GestureDetector(
                                  child: new Container(
                                    child: new Icon(
                                      alreadySaved ? Icons.favorite : Icons.favorite_border,
                                      color: alreadySaved ? Colors.red : null,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (alreadySaved) {
                                        alreadySaved = false;
                                      } else {
                                        alreadySaved = true;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            new Container(
                              child: new Text('配送范围：${widget.view?.peisong}米', style: new TextStyle(fontSize: 15),),
                              padding: new EdgeInsets.only(top: 15, bottom: 20),
                            ),
                            new Row(
                              children: <Widget>[
                                new Container(
                                  padding: new EdgeInsets.only(bottom: 10, right: 5, left: 5),
                                  child:  new Text('当日午餐',
                                    style: new TextStyle(
                                        color: Color.fromARGB(100, 0, 0, 128)
                                    ),
                                  ),
                                ),
                                new Container(
                                  padding: new EdgeInsets.only(bottom: 10, right: 5, left: 5),
                                  child: new Text('当日晚餐',
                                      style: new TextStyle(
                                          color: Color.fromRGBO(96, 96, 96, 0.5)
                                      )
                                  ),
                                ),
                                new Container(
                                  padding: new EdgeInsets.only( bottom: 10, right: 5, left: 5),
                                  child: new Text('当日夜宵',
                                      style: new TextStyle(
                                          color: Color.fromRGBO(96, 96, 96, 0.5)
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ]
                      )
                    ]
                ),
                new Container(
                  padding: new EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child:  new Text(
                    '美食介绍:',
                    style: new TextStyle(
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 255, 1),
                    ),
                  ),
                ),
                new Text(widget.view?.show),
                new Container(
                  padding: new EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child:  new Text(
                      '产品图片:',
                      style: new TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(0, 0, 255, 1),
                      ),
                      textAlign: TextAlign.left
                  ),
                ),

                new Row(
                  children: <Widget>[
                    new Image(
                      image: AssetImage(widget.view?.protuct_img),
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                    new Image(
                      image: AssetImage(widget.view?.protuct_img),
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Container(
                      padding: new EdgeInsets.only(top: 10, right: 30),
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, alreadySaved);
                        },
                        child: new Text('退出'),
                      ),
                    ),
                    new Container(
                      padding: new EdgeInsets.only(top: 10, left: 30),
                      child: new RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, alreadySaved);
                        },
                        child: new Text('查看商家'),
                      ),
                    ),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}


