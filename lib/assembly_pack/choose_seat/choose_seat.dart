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
  static const int _column = 20;

  GlobalKey<InteractiveViewerChildState> viewKey =
      GlobalKey<InteractiveViewerChildState>();

  // final RoomSeatModel data = RoomSeatModel()
  //   ..row = 10
  //   ..column = 6
  //   ..seats = [];
  // GlobalKey<SInteractiveViewerState> controller =
  //     GlobalKey<SInteractiveViewerState>();
  // SInteractiveViewerState state;

  @override
  void initState() {
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
              child: _buildTab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab() {
    return InteractiveViewerChild(
      key: viewKey,
      maxScale: 2,
      child: GestureDetector(
        child: Container(
          color: Colors.amberAccent,
          width: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int row = 0; row < _row; row++)
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 25,
                  width: 20,
                  alignment: Alignment.center,
                  child: Text(
                    '$row',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatTable() {
    return InteractiveViewerMain(
      maxScale: 2,
      onInteractionEnd: (ScaleEndDetails details) {
        viewKey.currentState?.onScaleEnd(details);
      },
      onInteractionStart: (ScaleStartDetails details) {
        viewKey.currentState?.onScaleStart(details);
      },
      onInteractionUpdate: (ScaleUpdateDetails details) {
        viewKey.currentState?.onScaleUpdate(details);
      },
      child: _wColumn(),
    );
  }

  Widget _wColumn() {
    return SingleChildScrollView(
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
                        margin: EdgeInsets.all(4),
                        height: 25,
                        width: 40,
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
          ),
        ),
      ),
    );
  }
}
