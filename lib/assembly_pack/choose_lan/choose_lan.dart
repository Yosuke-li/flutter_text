import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';

class Lang {
  String key;
  Locale value;

  Lang({required this.key, required this.value});
}

class ChooseLangPage extends StatefulWidget {
  const ChooseLangPage({Key? key}) : super(key: key);

  @override
  State<ChooseLangPage> createState() => _ChooseLangPageState();
}

class _ChooseLangPageState extends State<ChooseLangPage> {
  List<Lang> langs = [
    Lang(key: '简体中文', value: const Locale('zh')),
    Lang(key: 'English', value: const Locale('en')),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
          appBar: AppBar(
            title: Text('选择语言'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: langs
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        GlobalStore.locale = e.value;
                      },
                      child: Container(
                        color: GlobalStore.locale == e.value ? Colors.red : null,
                        child: Text('${e.key}'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )),
    );
  }
}
