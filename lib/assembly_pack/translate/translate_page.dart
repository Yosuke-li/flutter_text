import 'package:flutter/material.dart';
import 'package:flutter_text/api/translate.dart';
import 'package:flutter_text/model/translate.dart';

void main() => runApp(translatePage());

class translatePage extends StatefulWidget {
  translatePageState createState() => translatePageState();
}

class translatePageState extends State<translatePage> {
  TextEditingController _controller = new TextEditingController();
  Content content;

  void translateIt(String form, String to, String word) async {
    final result = await translateApi().getTrans(form, to, word);
    if (result != null) {
      setState(() {
        content = result;
      });
    }
  }

  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: TextField(
                onChanged: (val) {
                  translateIt('zh', 'ja', val);
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.compare_arrows),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(content?.out ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }
}
