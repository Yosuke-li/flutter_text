import 'dart:math';

import 'package:flutter/rendering.dart';

import '../init.dart';

typedef ViewCallback = void Function(int firstIndex, int lastIndex);

class ScrollListenerWidget extends StatelessWidget {
  final Widget child;
  final ViewCallback callback;

  const ScrollListenerWidget(
      {required this.callback, required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: _onNotification,
    );
  }

  bool _onNotification(ScrollNotification notice) {
    final SliverMultiBoxAdaptorElement sliverMultiBoxAdaptorElement =
        findSliverMutBoxAdaptorElement(notice.context! as Element)!;

    final double viewportDimension = notice.metrics.viewportDimension;
    int firstIndex = 0;
    int lastIndex = 0;

    void onVisitChildren(Element elemnt) {
      final SliverMultiBoxAdaptorParentData oldParentData =
          elemnt.renderObject?.parentData as SliverMultiBoxAdaptorParentData;
      double layoutOffset = oldParentData.layoutOffset!;
      double pixels = notice.metrics.pixels;
      double all = pixels + viewportDimension;

      if (layoutOffset >= pixels) {
        firstIndex = min(firstIndex, oldParentData.index! - 1);
        if (layoutOffset <= all) {
          lastIndex = max(lastIndex, oldParentData.index!);
        }
        firstIndex = max(firstIndex, 0);
      } else {
        lastIndex = firstIndex = oldParentData.index!;
      }
    }

    sliverMultiBoxAdaptorElement.visitChildren(onVisitChildren);

    callback(firstIndex, lastIndex);

    return false;
  }

  SliverMultiBoxAdaptorElement? findSliverMutBoxAdaptorElement(
      Element element) {
    if (element is SliverMultiBoxAdaptorElement) {
      return element;
    }
    SliverMultiBoxAdaptorElement? target;
    element.visitChildElements((Element child) {
      target ??= findSliverMutBoxAdaptorElement(child);
    });
    return target;
  }
}
