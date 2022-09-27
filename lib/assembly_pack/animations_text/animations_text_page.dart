import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_text/assembly_pack/animations_text/page_two.dart';

import '../../init.dart';

class AnimationsTextPage extends StatefulWidget {
  const AnimationsTextPage({Key? key}) : super(key: key);

  @override
  State<AnimationsTextPage> createState() => _AnimationsTextPageState();
}

class _AnimationsTextPageState extends State<AnimationsTextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xD2FE840A),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                ),
                child: AnimatedTextKit(
                  totalRepeatCount: 1,
                  onFinished: () {
                    NavigatorUtils.pushWidget(
                      context,
                      const APageTwo(),
                      replaceCurrent: true,
                      // type: AnimateType.Scale
                    );
                  },
                  animatedTexts: [
                    ScaleAnimatedText(
                      '5',
                      duration: const Duration(seconds: 1),
                    ),
                    ScaleAnimatedText(
                      '4',
                      duration: const Duration(seconds: 1),
                    ),
                    ScaleAnimatedText(
                      '3',
                      duration: const Duration(seconds: 1),
                    ),
                    ScaleAnimatedText(
                      '2',
                      duration: const Duration(seconds: 1),
                    ),
                    ScaleAnimatedText(
                      '1',
                      duration: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
