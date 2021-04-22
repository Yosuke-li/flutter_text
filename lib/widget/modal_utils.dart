import 'package:flutter/material.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';

class ModalUtils {
  static Future<bool> showModal(BuildContext context,
      {Color modalBackgroundColor,
        Text title,
        Widget icon,
        String message,
        Widget body,
        Text button1,
        bool outsideDismiss = true,
        bool cleanFocus = true,
        double marginBottom, //距离底部的高，使model偏上
        void Function(BuildContext context) onFun1,
        Text button2,
        void Function(BuildContext context) onFun2,
        Text button3,
        void Function(BuildContext context) onFun3,
        Widget dynamicBottom}) {
    if (modalBackgroundColor == null) {
      modalBackgroundColor = const Color(0xffffffff);
    }
    Widget Function(ModalStyle style) header;
    if (title != null) {
      header = (ModalStyle style) {
        return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: style.titleBackgroundColor,
                borderRadius: new BorderRadius.vertical(
                  top: Radius.elliptical(
                      screenUtil.adaptive(20), screenUtil.adaptive(20)),
                ),
              ),
              alignment: Alignment.center,
              height: screenUtil.adaptive(150),
              child: title,
            ),
            if (icon != null)
              Positioned(
                left: screenUtil.adaptive(20),
                top: 0,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: icon,
                ),
              )
          ],
        );
      };
    }
    Widget Function(ModalStyle style) bottom;
    if (button1 == null && button2 == null && button3 == null) {
      if (dynamicBottom != null) {
        bottom = (ModalStyle style) {
          return Container(
            padding: EdgeInsets.only(
                top: screenUtil.adaptive(20), bottom: screenUtil.adaptive(20)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(
                        screenUtil.adaptive(22), screenUtil.adaptive(22)))),
            margin: EdgeInsets.only(
              bottom: 0.0,
            ),
            child: dynamicBottom,
          );
        };
      } else {
        bottom = null;
      }
    } else {
      bottom = (ModalStyle style) {
        return Container(
          padding: EdgeInsets.only(
              top: screenUtil.adaptive(20), bottom: screenUtil.adaptive(22)),
          decoration: BoxDecoration(
              color: style.bottomBackgroundColor,
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(
                      screenUtil.adaptive(22), screenUtil.adaptive(22)))),
          margin: EdgeInsets.only(
            bottom: 0.0,
          ),
          child: Row(
            children: <Widget>[
              if (button1 != null)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (onFun1 != null) {
                        onFun1(context);
                      } else {
                        NavigatorUtils.pop(context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenUtil.adaptive(80),
                      child: button1,
                    ),
                  ),
                ),
              if (button2 != null)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (onFun2 != null) {
                        onFun2(context);
                      } else {
                        NavigatorUtils.pop(context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenUtil.adaptive(80),
                      child: button2,
                    ),
                  ),
                ),
              if (button3 != null)
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (onFun3 != null) {
                        onFun3(context);
                      } else {
                        NavigatorUtils.pop(context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: screenUtil.adaptive(80),
                      child: button3,
                    ),
                  ),
                ),
            ],
          ),
        );
      };
    }
    Widget Function(ModalStyle style) messageBody;
    if (message != null) {
      messageBody = (ModalStyle style) {
        return Container(
          color: style.messageBackgroundColor,
          padding: EdgeInsets.only(
              left: screenUtil.adaptive(25),
              right: screenUtil.adaptive(25),
              top: screenUtil.adaptive(20),
              bottom: screenUtil.adaptive(20)),
          child: Center(
            child: Text(
              message,
              style: style.messageStyle,
            ),
          ),
        );
      };
    }
    return NavigatorUtils.pushRoute<bool>(
        context,
        PageRouteBuilder<bool>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return _ModalWidget(
                context: context,
                outsideDismiss: outsideDismiss,
                header: header,
                body: body,
                messageBody: messageBody,
                bottom: bottom,
                modalColor: modalBackgroundColor,
                marginBottom: marginBottom,
              );
            },
            opaque: false),
        cleanFocus: cleanFocus);
  }
}

class _ModalWidget extends StatefulWidget {
  @required
  BuildContext context;
  Widget Function(ModalStyle style) header;
  Widget Function(ModalStyle style) messageBody;
  Widget body;
  Widget Function(ModalStyle style) bottom;
  bool outsideDismiss;
  Color modalColor;
  double marginBottom; //距离底部的高，使model偏上

  _ModalWidget({
    Key key,
    this.context,
    this.header,
    this.messageBody,
    this.body,
    this.bottom,
    this.outsideDismiss,
    this.modalColor,
    this.marginBottom,
  })  : assert(context != null),
        super(key: key);

  @override
  State<_ModalWidget> createState() => _Modal();
}

class _Modal extends State<_ModalWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.bottom == null) {
      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.pop(widget.context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ModalStyle _style = ModalStyleWidget.of(context).modalStyle;
    return Stack(children: <Widget>[
      Opacity(
        opacity: 0.4,
        child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: const DecoratedBox(
                decoration: BoxDecoration(color: Color(0xff000000)))),
      ),
      Center(
          child: GestureDetector(
            onTap: () {
              if (widget.outsideDismiss) {
                NavigatorUtils.pop(context);
              }
            },
            child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () {},
                  child: Center(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: widget.marginBottom ?? screenUtil.adaptive(200)),
                        child: Container(
                          padding: EdgeInsets.only(
                            top: screenUtil.adaptive(22),
                          ),
                          decoration: BoxDecoration(
                            color: widget.modalColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(
                                screenUtil.adaptive(20),
                                screenUtil.adaptive(20),
                              ),
                              bottom: Radius.elliptical(
                                screenUtil.adaptive(20),
                                screenUtil.adaptive(20),
                              ),
                            ),
                          ),
                          width: screenUtil.adaptive(858),
                          child: ListView(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: <Widget>[
                              if (widget.header != null) widget.header(_style),
                              if (widget.messageBody != null)
                                widget.messageBody(_style),
                              if (widget.body != null) widget.body,
                              if (widget.bottom != null) widget.bottom(_style),
                            ],
                          ),
                        ),
                      )),
                )),
          ))
    ]);
  }
}

class ModalStyle {
  final Color titleBackgroundColor;
  final Color messageBackgroundColor;
  final TextStyle messageStyle;
  final Color bottomBackgroundColor;

  ModalStyle(
      {this.titleBackgroundColor,
        this.messageBackgroundColor,
        this.messageStyle,
        this.bottomBackgroundColor});

  ModalStyle.fallback()
      : titleBackgroundColor = const Color(0xffffffff),
        messageBackgroundColor = const Color(0xffffffff),
        messageStyle = const TextStyle(color: Color(0xff949494)),
        bottomBackgroundColor = const Color(0xffffffff);

  ModalStyle merge(ModalStyle newStyle) {
    return ModalStyle(
      titleBackgroundColor:
      newStyle.titleBackgroundColor ?? this.titleBackgroundColor,
      messageBackgroundColor:
      newStyle.messageBackgroundColor ?? this.messageBackgroundColor,
      messageStyle: newStyle.messageStyle ?? this.messageStyle,
      bottomBackgroundColor:
      newStyle.bottomBackgroundColor ?? this.bottomBackgroundColor,
    );
  }
}

class _InheritedModalStyle extends InheritedWidget {
  const _InheritedModalStyle({
    Key key,
    @required this.data,
    @required Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  final _ModalStyleWidgetState data;

  @override
  bool updateShouldNotify(_InheritedModalStyle old) {
    return this.data != old.data;
  }
}

class ModalStyleWidget extends StatefulWidget {
  const ModalStyleWidget({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  _ModalStyleWidgetState createState() => new _ModalStyleWidgetState();

  static _ModalStyleWidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedModalStyle>().data;
  }
}

class _ModalStyleWidgetState extends State<ModalStyleWidget> {
  ModalStyle _style = ModalStyle.fallback();

  ModalStyle get modalStyle => _style;

  void modifyStyle(ModalStyle newModalStyle) {
    setState(() {
      _style = _style.merge(newModalStyle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedModalStyle(
      data: this,
      child: widget.child,
    );
  }
}
