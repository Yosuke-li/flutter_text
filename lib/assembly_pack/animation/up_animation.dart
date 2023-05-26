import 'package:flutter/material.dart';

typedef AnimateCallback = void Function(AnimationController controller);

///向上动画组件
class UpAnimationLayout extends StatefulWidget {
  final AnimateCallback? callback;
  final AnimationStatusListener? statusListener;
  final Widget child;
  final double? upOffset;
  final Duration? duration;

  const UpAnimationLayout(
      {super.key,
      required this.child,
      this.callback,
      this.statusListener,
      this.upOffset,
      this.duration});

  @override
  State<StatefulWidget> createState() => _UpAnimationLayoutState();
}

class _UpAnimationLayoutState extends State<UpAnimationLayout>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 500),
    )
      ..addListener(() {
        widget.callback?.call(_controller);
      })
      ..addStatusListener(widget.statusListener ?? (AnimationStatus status) {});
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
              begin: Offset(0, widget.upOffset ?? 0.5), end: Offset.zero)
          .animate(_controller),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
        child: widget.child,
      ),
    );
  }
}
