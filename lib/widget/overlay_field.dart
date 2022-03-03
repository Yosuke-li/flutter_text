import 'package:flutter/material.dart';

class OverlayField extends StatefulWidget {
  List<String> lists;

  OverlayField({Key key, this.lists}) : super(key: key);

  @override
  _OverlayFieldState createState() => _OverlayFieldState();
}

class _OverlayFieldState extends State<OverlayField> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
      }
    });
  }

  OverlayEntry _createOverlay() {
    final RenderBox renderBox = context.findRenderObject();
    final Size size = renderBox.size;

    return OverlayEntry(
      builder: (BuildContext context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: Material(
            elevation: 4,
            child: RepaintBoundary(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: widget.lists
                    ?.map(
                      (e) => ListTile(
                    title: Text(e),
                  ),
                )
                    ?.toList() ??
                    <String>[],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusNode,
      ),
    );
  }
}
