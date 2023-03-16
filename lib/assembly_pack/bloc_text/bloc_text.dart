import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/bloc_text/bloc_two.dart';
import 'package:flutter_text/assembly_pack/management/utils/navigator.dart';
import 'package:self_utils/utils/navigator.dart';
import 'package:self_utils/widget/bloc/bloc_widget.dart';

import 'bloc_model.dart';

class BlocTextWidget extends StatefulWidget {
  @override
  _BlocTextWidgetState createState() => _BlocTextWidgetState();
}

class _BlocTextWidgetState extends State<BlocTextWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocWidget<BlocModel>(bloc: BlocModel(), child: BlocPage()),
    );
  }
}

class BlocPage extends StatelessWidget {
  int i = 0; //todo 放外面就变全局变量了

  @override
  Widget build(BuildContext context) {
    final BlocModel bloc = BlocWidget.of<BlocModel>(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Text'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.outCount,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text('${snapshot.data ?? 0}');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right_alt),
        onPressed: () {
          WindowsNavigator().pushWidget(
              context,
              BlocTwo(
                blocModel: bloc,
              ));
        },
      ),
    );
  }
}
