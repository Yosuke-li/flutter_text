import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat/sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

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

//google登录
DatabaseReference reference = FirebaseDatabase.instance.reference().child('messages');
GoogleSignIn googleSignIn = new GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class ChatSceneState extends State<ChatScene> {
  final auth = FirebaseAuth.instance; //监听用户UID
  final analytics = new FirebaseAnalytics(); //监听事件
  final List<ChatMessage> _messages = <ChatMessage>[]; //监听信息
  final TextEditingController _textEditingController =
      new TextEditingController(); //输入框
  bool isComposer;
  GoogleSignInAccount _currentUser;

  //生命周期
  void initState() {
    super.initState();
    _ensureLoggedIn();
  }

  //google登录
  Future<void> _ensureLoggedIn() async {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    if (_currentUser == null) await googleSignIn.signInSilently();
    if (_currentUser == null) {
      await googleSignIn.signIn();
      analytics.logSignUp(); //google事件日志
    }
    // google用户登录
    if (auth.currentUser != null) {
      GoogleSignInAuthentication credentials =
          await googleSignIn.currentUser.authentication;
      final AuthCredential credential = await GoogleAuthProvider.getCredential(
        idToken: credentials.idToken,
        accessToken: credentials.accessToken,
      );
      await auth.signInWithCredential(credential);
      await auth.currentUser();
    }
  }

  Future<void> _handleSubmitted(String text) async {
    _textEditingController.clear();
    setState(() {
      isComposer = false;
    });
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
    analytics.logEvent(name: 'send_message'); //google事件日志
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
          Divider(height: 1.0),
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
      child: Container(
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
      ),
    );
  }
}
