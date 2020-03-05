import 'package:flutter/material.dart';

void main() => runApp(chatPackApp());

class chatPackApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "聊天",
      home: ChatScene(),
    );
  }
}

class ChatScene extends StatefulWidget {
  @override
  ChatSceneState createState() => ChatSceneState();
}

class ChatSceneState extends State<ChatScene> {
  final TextEditingController _textEditingController =
      new TextEditingController();

  void _handleSubmitted(String text) {
    _textEditingController.clear();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textEditingController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "发送消息"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textEditingController.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("聊天"),
      ),
      body: _buildTextComposer(),
    );
  }
}
