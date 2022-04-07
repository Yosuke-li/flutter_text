// import 'package:flutter_text/assembly_pack/choose_seat/interactive.dart';

import '../../init.dart';
import 'helper/room_seat.dart';

class ChooseSeat extends StatefulWidget {
  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  final RoomSeatModel data = RoomSeatModel()
    ..row = 10
    ..column = 6
    ..seats = [];
  // GlobalKey<SInteractiveViewerState> controller =
  //     GlobalKey<SInteractiveViewerState>();
  // SInteractiveViewerState state;

  @override
  void initState() {
    super.initState();
  }

  GestureScaleEndCallback onScaleEnd;

  GestureScaleUpdateCallback onScaleUpdate;

  GestureScaleStartCallback onScaleStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择位置'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: _buildView(),
        ),
      ),
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
    return InteractiveViewer(
      child: GestureDetector(
        child: Container(
          child: Column(
            children: [
              for (int row = 0; row < data.row; row++) Text('$row'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatTable() {
    return InteractiveViewer(
      maxScale: 2,
      onInteractionEnd: (ScaleEndDetails details) {
        Log.info(details);
      },
      onInteractionStart: (ScaleStartDetails details) {
        Log.info(details);
      },
      onInteractionUpdate: (ScaleUpdateDetails details) {
        Log.info(details);
      },
      child: Column(
        children: [
          for (int row = 0; row < data.row; row++)
            Row(
              children: [
                for (int column = 0; column < data.column; column++)
                  Container(
                    width: MediaQuery.of(context).size.width / data.column,
                    child: Text('($row, $column)'),
                  )
              ],
            )
        ],
      ),
    );
  }
}
