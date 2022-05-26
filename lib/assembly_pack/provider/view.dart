import 'package:flutter/material.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/widget/provider/base_model.dart';
import 'package:flutter_text/widget/provider/base_widget.dart';
import 'package:flutter_text/widget/provider/provider_model.dart';
import 'package:flutter_text/widget/provider/provider_setup.dart';
import 'package:provider/provider.dart';

class ProviderTextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        home: _BuildProviderView(),
      ),
    );
  }
}

class _BuildProviderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TextModel>(
      model: TextModel(),
      builder: (BuildContext context, TextModel model, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('provider demo'),
          ),
          body: Container(
            child: Row(
              children: [
                Text('点击次数为${model.count}'),
                InkWell(
                  onTap: () {
                    NavigatorUtils.pushWidget(context, SecondPage());
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TextModel>(
      model: TextModel(),
      builder: (BuildContext context, TextModel model, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('provider demo page 2'),
          ),
          body: Container(
            child: Row(
              children: [
                Text('点击次数为${model.count}'),
                InkWell(
                  onTap: () {
                    model.addCount();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
