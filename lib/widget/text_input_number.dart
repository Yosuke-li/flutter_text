import 'package:flutter/services.dart';
import 'package:flutter_text/init.dart';

class RulesFunc {
  void Function(TextEditingController controller) upRule;
  void Function(TextEditingController controller) downRule;

  RulesFunc({required this.upRule, required this.downRule});
}

class TextInputNumberUpDown extends StatefulWidget {
  final FormFieldSetter<String> onSave;
  final double? height;
  final Decoration? decoration;
  final RulesFunc rulesFunc;

  const TextInputNumberUpDown(Key? key, {
    required this.onSave,
    required this.rulesFunc,
    this.height,
    this.decoration,
  }) : super(key: key);

  @override
  _TextInputNumberUpDownState createState() => _TextInputNumberUpDownState();
}

class _TextInputNumberUpDownState extends State<TextInputNumberUpDown> {
  bool onLock = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 30,
      alignment: Alignment.centerLeft,
      decoration: widget.decoration ??
          BoxDecoration(
            border: Border.all(
              color: const Color(0xE6797979),
              width: 1.0,
            ),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: widget.height ?? 30,
              child: TextFormField(
                controller: controller,
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00ffffff),
                        width: 0.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00ffffff),
                        width: 0.0,
                      ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 6)),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onSaved: widget.onSave,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: screenUtil.adaptive(5)),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    widget.rulesFunc.upRule.call(controller);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: const Color(0xBFffffff),
                    size: screenUtil.adaptive(12),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.rulesFunc.downRule.call(controller);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xBFffffff),
                    size: screenUtil.adaptive(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
