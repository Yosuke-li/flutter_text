import 'package:flutter/material.dart';
import 'package:flutter_text/assembly_pack/chat_self/chat_room/view.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/navigator.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/widget/chat/helper/message/message_center.dart';
import 'package:flutter_text/widget/chat/helper/message/message_model.dart';

class ChatHeadPage extends StatefulWidget {
  int userId;
  String topic;
  Widget child;

  ChatHeadPage({Key key, @required this.topic, this.child, this.userId});

  @override
  _ChatHeadState createState() => _ChatHeadState();
}

class _ChatHeadState extends State<ChatHeadPage>
    with MessageCenter<ChatHeadPage> {
  MessageModel lastMsg;
  bool unRead = false;

  @override
  void initState() {
    super.initState();
    listener((MessageModel msg) {
      lastMsg = msg;
      unRead = true;
      if(mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        unRead = false;
        setState(() {});
        NavigatorUtils.getXOfPush(context, ChatRoomPage(),
            arguments: {'topic': widget.topic}).then((_) {
          unRead = false;
          setState(() {});
        });
      },
      child: Container(
        margin: EdgeInsets.all(
          screenUtil.adaptive(20),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: screenUtil.adaptive(120),
              height: screenUtil.adaptive(120),
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fattach.bbs.miui.com%2Fforum%2F201311%2F17%2F174124tp3sa6vvckc25oc8.jpg&refer=http%3A%2F%2Fattach.bbs.miui.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625624528&t=f27d73f1455c17f3fc1c4296f0e11957',
                      fit: BoxFit.fill,
                      width: screenUtil.adaptive(100),
                      height: screenUtil.adaptive(100),
                    ),
                  ),
                  Visibility(
                    visible: unRead,
                    child: Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: screenUtil.adaptive(25),
                        height: screenUtil.adaptive(25),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    left: screenUtil.adaptive(20),
                    right: screenUtil.adaptive(20)),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: screenUtil.adaptive(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text('${widget.topic}'),
                          ),
                          Visibility(
                            visible: lastMsg?.time != null,
                            child: Container(
                              child: Text(
                                  '${DateTimeHelper.datetimeFormat((lastMsg?.time ?? 0) ~/ 1000, 'yyyy-MM-dd')}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('${lastMsg?.msg ?? ''}'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  String get topic => widget.topic;
}