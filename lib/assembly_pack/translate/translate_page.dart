import 'package:flutter/material.dart';
import 'package:flutter_text/api/translate.dart';
import 'package:flutter_text/model/translate.dart';

void main() => runApp(translatePage());

class translatePage extends StatefulWidget {
  translatePageState createState() => translatePageState();
}

class translatePageState extends State<translatePage> {
  TextEditingController _controller = new TextEditingController();
  String f_lang = 'zh';
  String t_lang = 'ja';
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
                controller: _controller,
                onChanged: (val) {
                  translateIt(f_lang, t_lang, val);
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: DropdownButtonHideUnderline(
                          child: new DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('中文'),
                            value: 'zh',
                          ),
                          DropdownMenuItem(
                            child: Text('英文'),
                            value: 'en',
                          ),
                          DropdownMenuItem(
                            child: Text('日文'),
                            value: 'ja',
                          ),
                          DropdownMenuItem(
                            child: Text('韩文'),
                            value: 'ko',
                          ),
                          DropdownMenuItem(
                            child: Text('德语'),
                            value: 'de',
                          ),
                          DropdownMenuItem(
                            child: Text('法语'),
                            value: 'fr',
                          ),
                        ],
                        hint: Text(f_lang),
                        onChanged: (value) {
                          setState(() {
                            f_lang = value;
                          });
                          translateIt(f_lang, t_lang, _controller.text);
                        },
                        value: f_lang,
                      ))),
                  Icon(Icons.compare_arrows),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: new DropdownButton(
                      items: [
                        DropdownMenuItem(
                          child: Text('中文'),
                          value: 'zh',
                        ),
                        DropdownMenuItem(
                          child: Text('英文'),
                          value: 'en',
                        ),
                        DropdownMenuItem(
                          child: Text('日文'),
                          value: 'ja',
                        ),
                        DropdownMenuItem(
                          child: Text('韩文'),
                          value: 'ko',
                        ),
                        DropdownMenuItem(
                          child: Text('德语'),
                          value: 'de',
                        ),
                        DropdownMenuItem(
                          child: Text('法语'),
                          value: 'fr',
                        ),
                      ],
                      hint: Text(t_lang),
                      onChanged: (value) {
                        setState(() {
                          t_lang = value;
                        });
                        translateIt(f_lang, t_lang, _controller.text);
                      },
                      value: t_lang,
                    )),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(content?.out ?? ''),
                  if (content != null)
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {},
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
