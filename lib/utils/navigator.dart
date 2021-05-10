import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/utils/event_bus_helper.dart';

class NavigatorUtils {
  static Future<T> pushWidget<T>(
    BuildContext context,
    Widget widget, {
    bool replaceRoot = false,
    Duration duration,
    bool opaque = false,
    bool replaceCurrent = false,
    bool cleanFocus = false,
    bool isAddRoute = true,
  }) {
    if (isAddRoute == true)
      EventBusHelper.asyncStreamController.add(EventCache()..isRoute = true);
    if (cleanFocus == true)
      FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
    return pushRoute<T>(
      context,
      MaterialPageRoute<T>(builder: (BuildContext ctx) => widget),
      replaceRoot: replaceRoot,
      replaceCurrent: replaceCurrent,
    );
  }

  static Future<T> pushRoute<T>(
    BuildContext context,
    PageRoute<T> route, {
    bool replaceRoot = false,
    bool replaceCurrent = false,
    bool cleanFocus = false,
  }) {
    assert(!(replaceRoot == true && replaceCurrent == true));

    if (cleanFocus == true)
      FocusScope.of(context).unfocus(disposition: UnfocusDisposition.scope);
    if (replaceRoot == true) {
      return Navigator.pushAndRemoveUntil<T>(
        context,
        route,
        ModalRoute.withName('main'),
      );
    }
    if (replaceCurrent == true) {
      return Navigator.pushReplacement(context, route);
    }
    return Navigator.push<T>(context, route);
  }

  static bool pop(BuildContext context, {dynamic results}) {
    if (Navigator.of(context).canPop()) {
      EventBusHelper.asyncStreamController.add(EventCache().isRoute = false);
      Navigator.of(context).pop(results);
      return true;
    } else
      return false;
  }
}
