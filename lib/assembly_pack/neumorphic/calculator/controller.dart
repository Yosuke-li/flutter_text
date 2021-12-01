import 'package:flutter_text/init.dart';

class Controller extends ChangeNotifier {
  String text = '0';
  String beforeText = '';
  String operateText = '';

  void calcButtonAction(String value) {
    switch (value) {
      case 'AC':
        text = '0';
        beforeText = '';
        operateText = '';
        notifyListeners();
        break;
      case 'C':
        if (text != '0' && text.length >= 2) {
          text = text.substring(0, text.length - 1);
        } else if (text != '0' && text.length < 2) {
          if (operateText.isNotEmpty) {
            if (text.isEmpty) {
              operateText = '';
              text = beforeText;
              beforeText = '';
            } else {
              text = '';
            }
          } else {
            text = '0';
          }
        }
        notifyListeners();
        break;
      case '+/-':
        if (text.startsWith('-')) {
          text = text.substring(1);
        } else {
          text = '-$text';
        }
        notifyListeners();
        break;
      case '%':
        final double d = _value2Double(text);
        text = '${d / 100.0}';
        notifyListeners();
        break;
      case '+':
      case '-':
      case '*':
      case '/':
        if (operateText.isNotEmpty) {
          _onCount();
        }
        operateText = value;
        beforeText = text;
        text = '';
        notifyListeners();
        break;
      case '0':
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
      case '7':
      case '8':
      case '9':
      case '.':
        if (operateText.isNotEmpty && beforeText.isEmpty) {
          beforeText = text;
          text = '';
        }
        if (text.contains('.') && value == '.') {
          return;
        }
        text += value;
        if (!text.contains('.') && text.startsWith('0')) {
          text = text.substring(1);
        }
        notifyListeners();
        break;
      case '=':
        _onCount();
        beforeText = '';
        operateText = '';
        notifyListeners();
        break;
    }
  }

  void _onCount() {
    final double d = _value2Double(beforeText);
    final double d1 = _value2Double(text);
    switch (operateText) {
      case '+':
        text = '${d + d1}';
        break;
      case '-':
        text = '${d - d1}';
        break;
      case '*':
        text = '${d * d1}';
        break;
      case '/':
        text = '${d / d1}';
        break;
    }
  }

  double _value2Double(String value) {
    if (value.isEmpty) {
      return 0;
    }
    if (text.startsWith('-')) {
      String s = value.substring(1);
      return double.parse(s) * -1;
    } else {
      return double.parse(value);
    }
  }

  @override
  void dispose() {
    text = '0';
    beforeText = '';
    super.dispose();
  }
}
