import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/utils/array_helper.dart';
import 'package:flutter_text/widget/management/common/function_util.dart';

FormColumn<T> buildTextFormColumn<T>(
    {@required Widget title, @required String text(T value)}) {
  return FormColumn<T>(
      title: title, builder: (_, T value) => Text(text(value) ?? ''));
}

FormColumn<T> buildButtonFormColumn<T>(
    {@required Widget title, @required String text(T value), InFunc<T> onTap}) {
  return FormColumn<T>(
      title: title,
      builder: (_, T value) => ElevatedButton(
        child: Text(text(value)),
        onPressed: onTap == null
            ? null
            : () {
          onTap(value);
        },
      ));
}

FormColumn<T> buildIconButtonFormColumn<T>(
    {Widget title, IconData icon, InFunc<T> onTap}) {
  return FormColumn<T>(
      title: title,
      builder: (_, T value) => IconButton(
        icon: Icon(icon),
        onPressed: onTap == null
            ? null
            : () {
          onTap(value);
        },
      ));
}

class FormColumn<T> {
  final Widget title;
  final double width;
  final Widget Function(BuildContext context, T value) builder;

  FormColumn({@required this.title, @required this.builder, this.width});
}

class CommonForm<T> extends StatefulWidget {
  final List<FormColumn<T>> columns;
  final List<T> values;
  final bool canDrag;

  const CommonForm({Key key, @required this.columns, @required this.values, this.canDrag})
      : super(key: key);

  @override
  _CommonFormState<T> createState() => _CommonFormState<T>();
}

class _CommonFormState<T> extends State<CommonForm<T>> {
  Widget buildTitleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.columns
          .map(
              (e) => warpWidget(child: e.title, width: e.width))
          .toList(growable: false),
    );
  }

  Widget buildDragTitleRow(int index) {
    return LongPressDraggable(
      data: index,
      child: DragTarget<int>(
        onAccept: (data) {
          setState(() {
            final temp = widget.values[data];
            widget.values.remove(temp);
            widget.values.insert(index, temp);
          });
        },
        //绘制widget
        builder: (context, data, rejects) {
          return Row(
            children: widget.columns
                .map((e) => warpWidget(child: e.builder(context, ArrayHelper.get(widget.values, index))))
                .toList(growable: false),
          );
        },
        onLeave: (data) {
          print('$data is Leaving item $index');
        },
        onWillAccept: (data) {
          print('$index will accept item $data');
          return true;
        },
      ),
      onDragStarted: () {
        print('item $index ---------------------------onDragStarted');
      },
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        print(
            'item $index ---------------------------onDraggableCanceled,velocity = $velocity,offset = $offset');
      },
      onDragCompleted: () {
        print("item $index ---------------------------onDragCompleted");
      },
      feedback: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Colors.red),
        ),
        child: Row(
          children: widget.columns
              .map((e) => warpWidget(child: e.builder(context, ArrayHelper.get(widget.values, index))))
              .toList(growable: false),
        ),
      ),
    );
  }

  Widget buildRow(T value) {
    return Row(
      children: widget.columns
          .map((e) => warpWidget(child: e.builder(context, value)))
          .toList(growable: false),
    );
  }

  Widget warpWidget({Widget child, Color color, double width}) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.4, color: Color(0xE6797979)),
          color: color),
      height: 25,
      width: width ?? 125,
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      child: RepaintBoundary(
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(buildTitleRow());
    if (widget.canDrag == true) {
      for (int x = 0; x < widget.values.length; x++) {
        children.add(buildDragTitleRow(x));
      }
    } else {
      children.addAll(widget.values.map((e) => buildRow(e)));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
