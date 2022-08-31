// import 'package:flutter_text/assembly_pack/choose_seat/interactive.dart';

import 'package:flutter_text/assembly_pack/choose_seat/interactive_viewer_child.dart';

import '../../init.dart';
import 'helper/room_seat.dart';
import 'interactive_viewer_main.dart';

class ChooseSeat extends StatefulWidget {
  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  static const int _row = 10;
  static const int _column = 30;

  GlobalKey<InteractiveViewerChildState> viewKey =
      GlobalKey<InteractiveViewerChildState>();
  TransformationController? mainController;

  // final RoomSeatModel data = RoomSeatModel()
  //   ..row = 10
  //   ..column = 6
  //   ..seats = [];

  @override
  void initState() {
    mainController?.value = Matrix4.identity()..scale(0.2);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择位置'),
      ),
      body: _buildView(),
    );
  }

  Widget _buildView() {
    return Center(
      child: Container(
        child: Stack(
          children: [
            _buildSeatTable(),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                color: Colors.amberAccent,
                child: _buildTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab() {
    return InteractiveViewerChild(
      key: viewKey,
      minScale: 0.1,
      maxScale: 2,
      transformationController: mainController,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int row = 0; row < _row; row++)
            Container(
              margin: const EdgeInsets.all(4),
              height: 25,
              alignment: Alignment.center,
              child: Text(
                '$row',
                style: const TextStyle(color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSeatTable() {
    return InteractiveViewerMain(
      minScale: 0.1,
      maxScale: 2,
      transformationController: mainController,
      onInteractionEnd: (ScaleEndDetails details) {
        viewKey.currentState?.onScaleEnd(details);
      },
      onInteractionStart: (ScaleStartDetails details) {
        viewKey.currentState?.onScaleStart(details);
      },
      onInteractionUpdate: (ScaleUpdateDetails details) {
        viewKey.currentState?.onScaleUpdate(details);
      },
      child: _table(),
    );
  }


Widget _table() {
    return Table(
      columnWidths: <int, TableColumnWidth>{
        for (int i = 0; i < _column; i++) i: const FlexColumnWidth(1),
      },
      children: <TableRow>[
        for (int row = 0; row < _row; row += 1)
          TableRow(
            children: <Widget>[
              for (int column = 0; column < _column; column += 1)
                Container(
                  margin: EdgeInsets.all(4),
                  height: 25,
                  width: 20,
                  alignment: Alignment.center,
                  color: Colors.blueAccent,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  Widget _wColumn() {
    return GestureDetector(
      onTap: () {},
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: RepaintBoundary(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                for (int row = 0; row < _row; row += 1)
                  Row(
                    children: <Widget>[
                      for (int column = 0; column < _column; column += 1)
                        Container(
                          margin: const EdgeInsets.all(4),
                          height: 25,
                          width: 40,
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: const Text(
                            '',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
