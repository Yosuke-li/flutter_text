import '../../init.dart';
import 'dart:math';

class JoyCon extends StatefulWidget {
  final void Function(Offset offset) onChange;

  const JoyCon({required this.onChange, Key? key}) : super(key: key);

  @override
  State<JoyCon> createState() => _JoyConState();
}

class _JoyConState extends State<JoyCon> {
  Offset delta = Offset.zero;

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() {
      delta = newDelta;
    });
  }

  void calculateDelta(Offset offset) {
    final Offset newDelta = offset - const Offset(60, 60);
    updateDelta(Offset.fromDirection(
      newDelta.direction,
      min(30, newDelta.distance),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0x88ffffff),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Transform.translate(
                offset: delta,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xccffffff),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPanDown: onDragDown,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,),
      ),
    );
  }

  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    updateDelta(Offset.zero);
  }
}
