import 'package:flutter_text/assembly_pack/slide_image/slide_card.dart';
import 'package:flutter_text/init.dart';

import 'movie.dart';

class SlideImagePage extends StatefulWidget {
  @override
  _SlideImageState createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImagePage> {
  PageController controller;
  double pageOffset = 0;

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
                    children: [
                      SlidingCard(
                        offset: pageOffset - 0,
                        movie: Movie(
                            price: '100',
                            name: '123',
                            date: '2021-09-12',
                            desc: '23a1s32',
                            image: 'assets/banner/back.png'),
                      ),
                      SlidingCard(
                        offset: pageOffset - 1,
                        movie: Movie(
                            price: '100',
                            name: '123',
                            date: '2021-09-12',
                            desc: '23a1s32',
                            image: 'assets/banner/fore.png'),
                      ),SlidingCard(
                        offset: pageOffset - 2,
                        movie: Movie(
                            price: '100',
                            name: '123',
                            date: '2021-09-12',
                            desc: '23a1s32',
                            image: 'assets/banner/back.png'),
                      ),
                    ],
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
