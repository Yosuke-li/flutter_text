// import 'package:flutter_text/assembly_pack/choose_seat/interactive.dart';

import '../../init.dart';
import 'helper/room_seat.dart';

class ChooseSeat extends StatefulWidget {
  @override
  _ChooseSeatState createState() => _ChooseSeatState();
}

class _ChooseSeatState extends State<ChooseSeat> {
  static const int _row = 20;
  static const int _column = 6;
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
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          child: _buildSeatTable(),
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
            // Positioned(
            //   right: 0,
            //   top: 0,
            //   child: _buildTab(),
            // ),
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
              // for (int row = 0; row < data.row; row++) Text('$row'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatTable() {
    return InteractiveViewer(
      // maxScale: 2,
      constrained: false,
      scaleEnabled: false,
      onInteractionEnd: (ScaleEndDetails details) {
        Log.info(details);
      },
      onInteractionStart: (ScaleStartDetails details) {
        Log.info(details);
      },
      onInteractionUpdate: (ScaleUpdateDetails details) {
        Log.info(details);
      },
      child: SingleChildScrollView(
        child: Table(
          columnWidths: <int, TableColumnWidth>{
            for (int i = 0; i<_column; i++)
              i: const FlexColumnWidth(150),
          },
          children: <TableRow>[
            for (int row = 0; row < _row; row += 1)
              TableRow(
                children: <Widget>[
                  for (int column = 0; column < _column; column += 1)
                    Container(
                      margin: EdgeInsets.all(2),
                      height: 50,
                      width: 100,
                      alignment: Alignment.center,
                      color: Colors.blueAccent,
                      child: Text('($row,$column)',style: TextStyle(fontSize: 20),),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
