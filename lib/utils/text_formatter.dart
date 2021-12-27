import 'package:flutter/services.dart';
import 'package:flutter_text/utils/array_helper.dart';

//用于输入金钱 如 ：21.2121
class TlMoneyTextInputFormatter extends TextInputFormatter {
  TlMoneyTextInputFormatter(this.integerMaxLen, {this.decimalMaxLen})
      : assert((integerMaxLen == null || integerMaxLen > 0) ||
      (decimalMaxLen == null && decimalMaxLen > 0));
  final int integerMaxLen; //整数位
  final int decimalMaxLen; //小数位
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    return _getValue(oldValue, newValue, integerMaxLen, decimalMaxLen);
  }

  static TextEditingValue _getValue(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      int integerMaxLen,
      int decimalMaxLen) {
    final int len = newValue.text?.length ?? 0;
    bool isHas = false; //是否有小数点
    for (int i = 0; i < len; i++) {
      if (newValue.text[i] == '.' && i == 0)
        return oldValue;
      else if (newValue.text[i] == '.' && isHas == false) {
        isHas = true;
      } else if (newValue.text[i] == '.' && isHas == true) return oldValue;
    }

    if (isHas == true) {
      if ((decimalMaxLen ?? 0) == 0) {
        return oldValue;
      }
      final List<String> list = newValue.text.split('.');
      if (list[0].length > integerMaxLen ||
          ((ArrayHelper.get(list, 1))?.length ?? 0) > decimalMaxLen) {
        return oldValue;
      }
    } else if (newValue.text.length > integerMaxLen) {
      return oldValue;
    }
    return newValue;
  }
}

//在拼写时跳过格式化
class TLLengthLimitingTextInputFormatter
    extends LengthLimitingTextInputFormatter {
  TLLengthLimitingTextInputFormatter(int maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.runes.length > maxLength &&
        oldValue.composing == TextRange.empty &&
        newValue.composing != TextRange.empty) {
      return super.formatEditUpdate(oldValue, newValue);
    }
    if (newValue.composing == TextRange.empty) {
      return super.formatEditUpdate(oldValue, newValue);
    }
    return newValue;
  }
}

//在拼写时跳过格式化
class TLPinyinWhitelistingTextInputFormatter
    extends FilteringTextInputFormatter {
  TLPinyinWhitelistingTextInputFormatter(Pattern whitelistedPattern)
      : super.allow(whitelistedPattern);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.composing == TextRange.empty) {
      return super.formatEditUpdate(oldValue, newValue);
    }
    return newValue;
  }
}

class TlTextInputFormatterHelper {
  ///身份证校验
  static List<TextInputFormatter> get idCardInputFormatter =>
      <TextInputFormatter>[
        TLPinyinWhitelistingTextInputFormatter(RegExp('[0-9Xx]')),
        TLLengthLimitingTextInputFormatter(18),
        TextInputFormatter.withFunction((
            TextEditingValue oldValue,
            TextEditingValue newValue,
            ) {
          final String last = newValue.text.length > 1
              ? newValue.text[newValue.text.length - 1]
              : '';
          if (newValue.text.length < 17 && last?.toLowerCase() == 'x') {
            return oldValue;
          }
          return newValue;
        })
      ];

  ///不允许输入空格
  static TextInputFormatter get removeBlank => TextInputFormatter.withFunction((
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.composing == TextRange.empty) {
      if (newValue.text.length > (oldValue.text?.length ?? 0)) {
        final String temp = newValue.text.replaceAll(' ', '');
        if (temp.length != newValue.text.length) {
          return oldValue;
        }
      }
    }
    return newValue;
  });

  ///手机号
  static List<TextInputFormatter> get phoneInputFormatter =>
      <TextInputFormatter>[
        TLPinyinWhitelistingTextInputFormatter(RegExp('[0-9]')),
        TLLengthLimitingTextInputFormatter(11),
      ];

  ///整数或小数
  static TextInputFormatter get doubleInputFormatter =>
      FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'));

  ///价格
  static List<TextInputFormatter> priceInputFormatter(int integerMaxLen,
      {int decimalMaxLen}) {
    return <TextInputFormatter>[
      TlMoneyTextInputFormatter(integerMaxLen, decimalMaxLen: decimalMaxLen),
      doubleInputFormatter,
    ];
  }
}
