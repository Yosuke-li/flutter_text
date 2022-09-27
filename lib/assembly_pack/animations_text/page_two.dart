import 'package:animated_text_kit/animated_text_kit.dart';

import '../../init.dart';

class APageTwo extends StatefulWidget {
  const APageTwo({Key? key}) : super(key: key);

  @override
  State<APageTwo> createState() => _APageTwoState();
}

class _APageTwoState extends State<APageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color(0xD2FE840A),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                const Text(
                  'Be',
                  style: TextStyle(
                    fontSize: 43,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 20,
                  height: 100,
                ),
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 40),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('Future'),
                      RotateAnimatedText('Awesome'),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 43,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText('text'),
                  FadeAnimatedText('Sec'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 43,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText('Animated Text that displays a [Text]'),
                  TyperAnimatedText('element as if it is being typed one'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 43,
                color: Colors.white,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Animated Text that displays a [Text]',
                    speed: const Duration(milliseconds: 100),
                  ),
                  TypewriterAnimatedText(
                    'element as if it is being typed one',
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Animated Text',
                  textStyle: const TextStyle(
                    fontSize: 43,
                    color: Colors.white,
                  ),
                  colors: [Colors.purple, Colors.blue, Colors.yellow],
                  speed: const Duration(milliseconds: 200),
                ),
                ColorizeAnimatedText(
                  'typed one',
                  textStyle: const TextStyle(
                    fontSize: 43,
                    color: Colors.white,
                  ),
                  colors: [Colors.purple, Colors.blue, Colors.yellow],
                  speed: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText(
                  'Hello World',
                  textStyle: const TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(
                  'cyberpunk',
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontFamily: 'Avalien',
                    package: 'self_utils',
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),FlickerAnimatedText(
                  '2077',
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontFamily: 'Avalien',
                    package: 'self_utils',
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 7.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
