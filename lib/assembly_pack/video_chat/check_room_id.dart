import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/video_chat/video_chat.dart';

void main() => runApp(CheckRoomId());

class CheckRoomId extends StatefulWidget {
  _CheckRoomState createState() => _CheckRoomState();
}

class _CheckRoomState extends State<CheckRoomId> {
  TextEditingController _controller = new TextEditingController();
  bool is_video_chat = true;

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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('视频通话模式'),
                      Checkbox(
                        value: is_video_chat,
                        onChanged: (val) {
                          setState(() {
                            if (!is_video_chat) {
                              is_video_chat = true;
                            }
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('直播模式'),
                      Checkbox(
                        value: !is_video_chat,
                        onChanged: (val) {
                          setState(() {
                            if (is_video_chat) {
                              is_video_chat = false;
                            }
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                print(_controller.text);
                if (_controller.text.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoChat(
                            channelName: _controller.text,
                            is_video: is_video_chat,
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
