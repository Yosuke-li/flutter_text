import 'package:flutter_text/assembly_pack/slide_image/slide_card.dart';
import 'package:flutter_text/init.dart';
import 'package:flutter_text/utils/array_helper.dart';

import 'movie.dart';

class SlideImagePage extends StatefulWidget {
  @override
  _SlideImageState createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImagePage> {
  PageController controller;
  double pageOffset = 0;

  List<Movie> movies = <Movie>[
    Movie(
      name: '怒火・重案',
      desc: '重案组布网围剿国际毒枭，突然杀出一组蒙面悍匪 '
          '“黑吃黑”，更冷血屠杀众警察。重案组督察张崇邦（甄子丹 饰）亲睹战友被杀，深入追查发现，悍匪首领竟是昔日战友邱刚敖（谢霆锋 饰）。',
      image: 'assets/banner/back.png',
      date: '2021-07-30',
      price: '19.99',
    ),
    Movie(
      name: '沙丘・Dune',
      desc: '电影《沙丘》为观众呈现了一段神秘而感人至深的英雄之旅。天赋异禀的少年保罗・厄崔迪被命运指引，为了保卫自己的家族和人民，决心前往'
          '浩瀚宇宙间最危险的星球，开启一场惊心动魄的冒险。与此同时，各路势力为了抢夺这颗星球上一种能够释放人类最大潜力的珍贵资源而纷纷加入战场。最终，唯有那些能够战胜内心恐惧的人才能生存下去。',
      image: 'assets/banner/fore.png',
      date: '2021-09-03',
      price: '29.99',
    ),
    Movie(
      name: '速度与激情 9',
      desc:
          '“唐老大” 多姆・托莱多（范・迪塞尔 饰）与莱蒂（米歇尔・罗德里格兹 饰）和他的儿子小布莱恩，过上了远离纷扰的平静生活。然而他们也知道，安宁之下总潜藏着危机。这一次，为了保护他所爱的人，唐老大不得不直面过去。他和伙伴们面临的是一场足以引起世界动荡的阴谋，以及一个前所未遇的一流杀手和高能车手。而这个名叫雅各布（约翰・塞纳 饰）的人，恰巧是多姆遗落在外的亲弟弟。',
      image: 'assets/banner/back.png',
      date: '2021-05-21',
      price: '9.99',
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: 0.8);
    controller.addListener(() {
      setState(() {
        pageOffset = controller.page;
      });
      Log.info(pageOffset);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: RepaintBoundary(
                  child: PageView(
                    controller: controller,
                    children: List<Widget>.generate(
                      movies.length,
                      (int index) => SlidingCard(
                        offset: pageOffset - index,
                        movie: ArrayHelper.get(movies, index),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
