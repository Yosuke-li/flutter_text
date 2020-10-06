import 'package:flutter/material.dart';
import 'package:flutter_text/utils/web_url.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SchemeText());

class SchemeText extends StatefulWidget {
  _SchemeTextState createState() => _SchemeTextState();
}

class _SchemeTextState extends State<SchemeText> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scheme 测试'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '跳转到exhibition',
                ),
                onPressed: () async {
                  WebUrl.launchUrl('exhibition://');
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '跳转到错误链接',
                ),
                onPressed: () async {
                  WebUrl.launchUrl('exhibition//');
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: RaisedButton(
                color: Theme.of(context).primaryColorDark,
                textColor: Theme.of(context).primaryColorLight,
                child: Text(
                  '跳转到flutter text',
                ),
                onPressed: () async {
                  WebUrl.launchUrl('flutterTextLx://');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
