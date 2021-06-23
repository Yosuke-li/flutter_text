import 'dart:math';

import 'package:flutter/material.dart';

class IntroHelper {
  static Map smartGetPosition({
    @required Size size,
    @required Size screenSize,
    @required Offset offset,
  }) =>
      _smartGetPosition(size: size, screenSize: screenSize, offset: offset);

  static Map _smartGetPosition({
    @required Size size,
    @required Size screenSize,
    @required Offset offset,
  }) {
    double height = size.height;
    double width = size.width;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double bottomArea = screenHeight - offset.dy - height;
    double topArea = screenHeight - height - bottomArea;
    double rightArea = screenWidth - offset.dx - width;
    double leftArea = screenWidth - width - rightArea;
    Map position = Map();
    position['crossAxisAlignment'] = CrossAxisAlignment.start;

    if (topArea > bottomArea) {
      position['bottom'] = bottomArea + height + 16;
    } else {
      position['top'] = offset.dy + height + 12;
    }

    if (leftArea > rightArea) {
      position['right'] = rightArea <= 0 ? 16.0 : rightArea;
      position['crossAxisAlignment'] = CrossAxisAlignment.end;
      position['width'] = min(leftArea + width - 16, screenWidth * 0.618);
    } else {
      position['left'] = offset.dx <= 0 ? 16.0 : offset.dx;
      position['width'] = min(rightArea + width - 16, screenWidth * 0.618);
    }

    /// The distance on the right side is very large, it is more beautiful on the right side
    if (rightArea > 0.8 * topArea && rightArea > 0.8 * bottomArea) {
      position['left'] = offset.dx + width + 16;
      position['top'] = offset.dy - 4;
      position['bottom'] = null;
      position['right'] = null;
      position['width'] = min<double>(position['width'], rightArea * 0.8);
    }

    /// The distance on the left is large, it is more beautiful on the left side
    if (leftArea > 0.8 * topArea && leftArea > 0.8 * bottomArea) {
      position['right'] = rightArea + width + 16;
      position['top'] = offset.dy - 4;
      position['bottom'] = null;
      position['left'] = null;
      position['crossAxisAlignment'] = CrossAxisAlignment.end;
      position['width'] = min<double>(position['width'], leftArea * 0.8);
    }

    return position;
  }
}


///intro = Intro(
//       stepCount: 4,
//       maskClosable: true,
//       onHighlightWidgetTap: (IntroStatus introStatus) {
//         print(introStatus);
//       },
//         // StepWidgetBuilder.useDefaultTheme(texts: texts, buttonTextBuilder: buttonTextBuilder)
//
//       /// use defaultTheme
//       widgetBuilder: (StepWidgetParams params) {
//         Map position = IntroHelper.smartGetPosition(
//           screenSize: params.screenSize,
//           size: params.size,
//           offset: params.offset,
//         );
//
//         List<String> texts = [
//           'Hello, I\'m Flutter Intro.',
//           'I can help you quickly implement the Step By Step guide in the Flutter project.',
//           'My usage is also very simple, you can quickly learn and use it through example and api documentation.',
//           'In order to quickly implement the guidance, I also provide a set of out-of-the-box themes, I wish you all a happy use, goodbye!',
//         ];
//         return Stack(
//           children: [
//             Positioned(
//               child: Container(
//                 width: position['width'],
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: position['crossAxisAlignment'],
//                   children: [
//                     Text(
//                       '${texts[params.currentStepIndex]}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         if (params.currentStepIndex + 1 != params.stepCount)
//                           OutlinedButton(
//                             style: ButtonStyle(
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                 Colors.white,
//                               ),
//                               overlayColor: MaterialStateProperty.all<Color>(
//                                 Colors.white.withOpacity(0.1),
//                               ),
//                               side: MaterialStateProperty.all<BorderSide>(
//                                 BorderSide(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                                 EdgeInsets.symmetric(
//                                   vertical: 0,
//                                   horizontal: 8,
//                                 ),
//                               ),
//                               shape: MaterialStateProperty.all<OutlinedBorder>(
//                                 StadiumBorder(),
//                               ),
//                             ),
//                             onPressed: () {
//                               params.onNext();
//                             },
//                             child: const Text(
//                               'next',
//                               style: TextStyle(
//                                 fontSize: 15,
//                               ),
//                             ),
//                           ),
//                         const SizedBox(
//                           width: 16,
//                         ),
//                         OutlinedButton(
//                           style: ButtonStyle(
//                             foregroundColor: MaterialStateProperty.all<Color>(
//                               Colors.white,
//                             ),
//                             overlayColor: MaterialStateProperty.all<Color>(
//                               Colors.white.withOpacity(0.1),
//                             ),
//                             side: MaterialStateProperty.all<BorderSide>(
//                               BorderSide(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                               EdgeInsets.symmetric(
//                                 vertical: 0,
//                                 horizontal: 8,
//                               ),
//                             ),
//                             shape: MaterialStateProperty.all<OutlinedBorder>(
//                               StadiumBorder(),
//                             ),
//                           ),
//                           onPressed: () {
//                             params.onFinish();
//                           },
//                           child: const Text(
//                             'Finish',
//                             style: TextStyle(
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               top: position['top'],
//               right: position['right'],
//               left: position['left'],
//               bottom: position['bottom'],
//             )
//           ],
//         );
//       },
//     );