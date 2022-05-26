import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/api/baidu_tts.dart';
import 'package:flutter_text/api/translate.dart';
import 'package:flutter_text/model/baidu_tts.dart';
import 'package:flutter_text/model/translate.dart';

class translatePage extends StatefulWidget {

  @override
  translatePageState createState() => translatePageState();
}

class translatePageState extends State<translatePage> {
  TextEditingController _controller = new TextEditingController();
  AudioPlayer audioPlayer = new AudioPlayer();
  String f_lang = 'zh';
  String t_lang = 'ja';
  late Content content;
  late ContentE contentE;
  late Token _token;
  int status = 1;

  //调用翻译接口
  void translateIt(String form, String to, String word) async {
    final result = await translateApi().getTrans(form, to, word);
    if (result != null) {
      if (result['status'] == 1) {
        setState(() {
          status = result['status'];
          content = result['Content'];
        });
      } else if (result['status'] == 0) {
        setState(() {
          status = result['status'];
          contentE = result['Content'];
        });
      }
    }
  }

  //获取百度tts的token
  void getToken() async {
    final result = await BaiduTtsApi().getBaiduToken();
    if (result != null) {
      setState(() {
        _token = result;
      });
    }
  }

  //播放
  Future<void> play(url) async {
    await audioPlayer.play(url);
  }

  void initState() {
    super.initState();
    getToken();
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
                          child: DropdownButton<String>(
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
                          print(value);
                          setState(() {
                            f_lang = value!;
                          });
                          translateIt(f_lang, t_lang, _controller.text);
                        },
                        value: f_lang,
                      ))),
                  Icon(Icons.compare_arrows),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
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
                          t_lang = value!;
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
              child: status == 1
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(content.out ?? ''),
                  IconButton(
                    icon: Icon(Icons.volume_up),
                    onPressed: () {
                      play(BaiduTtsApi().TtsUrl +
                          Uri.encodeComponent(content.out??'') +
                          BaiduTtsApi().TTs_text +
                          _token.access_token!);
                    },
                  )
                ],
              )
                  : Column(
                children: <Widget>[
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        '${contentE.word_mean.toString()}',
                        softWrap: false,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.volume_up),
                    onPressed: () {
                      play(contentE.ph_am_mp3);
                    },
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
