import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/video_chat/video_chat.dart';

void main() => runApp(CheckRoomId());

class CheckRoomId extends StatefulWidget {
  _CheckRoomState createState() => _CheckRoomState();
}

class _CheckRoomState extends State<CheckRoomId> {
  TextEditingController _controller = new TextEditingController();

  void dispose() {
    // dispose input controller
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择RoomId'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
            ),
            RaisedButton(
              onPressed: () {
                print(_controller.text);
                if (_controller.text.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoChat(
                            channelName: _controller.text,
                          )));
                }
              },
              child: Text('Join'),
            )
          ],
        ),
      ),
    );
  }
}
