import 'package:flutter/material.dart';
import 'package:flutter_text/widget/management/common/function_util.dart';

FormColumn<T> buildTextFormColumn<T>(
    {@required String title, @required String text(T value)}) {
  return FormColumn<T>(
      title: title, builder: (_, T value) => Text(text(value) ?? ''));
}

FormColumn<T> buildButtonFormColumn<T>(
    {@required String title, @required String text(T value), InFunc<T> onTap}) {
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
    {String title, IconData icon, InFunc<T> onTap}) {
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
  final String title;
  final Widget Function(BuildContext context, T value) builder;

  FormColumn({@required this.title, @required this.builder});
}

class CommonForm<T> extends StatefulWidget {
  final List<FormColumn<T>> columns;
  final List<T> values;

  const CommonForm({Key key, @required this.columns, @required this.values})
      : super(key: key);

  @override
  _CommonFormState<T> createState() => _CommonFormState<T>();
}

class _CommonFormState<T> extends State<CommonForm<T>> {
  Widget buildTitleRow() {
    return Row(
      children: widget.columns
          .map(
              (e) => warpWidget(child: Text(e.title), color: Color(0xfff5fafe)))
          .toList(growable: false),
    );
  }

  Widget buildRow(T value) {
    return Row(
      children: widget.columns
          .map((e) => warpWidget(child: e.builder(context, value)))
          .toList(growable: false),
    );
  }

  Widget warpWidget({Widget child, Color color}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.4, color: Colors.black26),
            color: color),
        height: 40,
        padding: const EdgeInsets.all(4),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    children.add(buildTitleRow());
    children.addAll(widget.values.map((e) => buildRow(e)));

    return Container(
      child: Column(
        children: children,
      ),
    );
  }
}
