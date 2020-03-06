import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat/sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class ChatSceneState extends State<ChatScene> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textEditingController =
      new TextEditingController();
  bool isComposer;
  GoogleSignInAccount _currentUser;

  //google登录
  Future<void> _ensureLoggedIn() async {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    if (_currentUser == null) await googleSignIn.signInSilently();
    if (_currentUser == null) await googleSignIn.signIn();
  }

  Future<void> _handleSubmitted(String text) async {
    _textEditingController.clear();
    setState(() {
      isComposer = false;
    });
    await _ensureLoggedIn();
    _sendMessage(text: text);
  }

  //发送消息
  void _sendMessage({String text}) {
    ChatMessage message = new ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
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
              onChanged: (String text) {
                setState(() {
                  isComposer = text.length > 0;
                });
              },
              decoration: InputDecoration.collapsed(hintText: "发送消息"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => isComposer
                  ? _handleSubmitted(_textEditingController.text)
                  : null,
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
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SignInDemo()),
            ),
            child: Text("SignIn"),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, int index) {
                  return _messages[index];
                }),
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 16),
              child: GoogleUserCircleAvatar(
                identity: googleSignIn.currentUser,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(googleSignIn.currentUser.displayName),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          )
        ],
      ),
    );
  }
}
