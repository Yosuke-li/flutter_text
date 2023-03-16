import 'package:flutter_text/assembly_pack/management/home_page/editor.dart';
import 'package:flutter_text/init.dart';
import 'package:self_utils/init.dart';

class WindowsNavigator extends NavigatorUtils {
  static late EditorController c;

  static void init(EditorController controller) {
    c = controller;
  }

  @override
  Future<T?>? pushWidget<T>(
    BuildContext context,
    Widget widget, {
    bool replaceRoot = false,
    Duration? duration,
    bool opaque = false,
    bool replaceCurrent = false,
    bool cleanFocus = false,
    bool isAddRoute = true,
    AnimateType? type,
  }) {
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      c.open(
          key: ViewKey(
              namespace: widget.hashCode.toString(),
              id: widget.hashCode.toString()),
          tab: widget.hashCode.toString(),
          contentIfAbsent: (_) => widget);
      return null;
    } else {
      return super.pushWidget(context, widget,
          isAddRoute: isAddRoute,
          replaceCurrent: replaceCurrent,
          replaceRoot: replaceRoot,
          duration: duration,
          opaque: opaque,
          cleanFocus: cleanFocus,
          type: type);
    }
  }
}
