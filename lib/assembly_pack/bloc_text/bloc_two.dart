import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/bloc_text/bloc_model.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/widget/bloc/bloc_widget.dart';

import 'bloc_two_model.dart';

class BlocTwo extends StatefulWidget {
  BlocModel blocModel;

  BlocTwo({this.blocModel});

  @override
  _BlocTwoState createState() => _BlocTwoState();
}

class _BlocTwoState extends State<BlocTwo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Log.info('widget.blocModel.count: ${widget.blocModel.count}');
  }

  @override
  Widget build(BuildContext context) {
    return BlocWidget<BlocTwoModel>(
      bloc: BlocTwoModel(),
      child: _BlocTwoPage()
        ..blocModel = widget.blocModel
        ..i = widget.blocModel.count,
    );
  }
}

class _BlocTwoPage extends StatelessWidget {
  int i = 0;
  BlocModel blocModel;

  @override
  Widget build(BuildContext context) {
    final BlocTwoModel bloc = BlocWidget.of<BlocTwoModel>(context);
    final BlocModel firstBloc = blocModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Text'),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: bloc.outCount,
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text('$i');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final int sum = i++;
          bloc.actionStream.add(sum);
          firstBloc.actionStream.add(sum);
        },
      ),
    );
  }
}