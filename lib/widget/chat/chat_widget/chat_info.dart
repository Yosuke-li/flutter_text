import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_text/global/global.dart';
import 'package:flutter_text/utils/datetime_utils.dart';
import 'package:flutter_text/utils/log_utils.dart';
import 'package:flutter_text/utils/screen.dart';
import 'package:flutter_text/utils/toast_utils.dart';
import 'package:flutter_text/widget/api_call_back.dart';
import 'package:flutter_text/widget/chat/helper/message/message_center.dart';
import 'package:flutter_text/widget/chat/helper/message/message_model.dart';
import 'package:flutter_text/widget/chat/helper/user/user.dart';
import 'package:flutter_text/widget/chat/helper/user/user_cache.dart';
import 'package:flutter_text/widget/notification_center/notification_listener.dart';
import 'package:flutter_text/widget/notification_center/notification_model.dart';

import '../../image_zoomable.dart';

class ChatInfoPage extends StatefulWidget {
  String topic;

  ChatInfoPage({@required this.topic});

  @override
  _ChatInfoState createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfoPage>
    with MessageCenter<ChatInfoPage>, WidgetsBindingObserver {
  List<MessageModel> msgs = [];
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textEditingController =
      TextEditingController(); //输入框
  bool isComposer = false; //输入框判断
  final FocusNode _node = FocusNode();

  AppLifecycleState _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getTopicMsg((List<MessageModel> list) {
      msgs = list;
      onScrollBottom();
      setState(() {});
    });
    listener((MessageModel msg) {
      /// 不在当前页面显示弹窗
      if (_state == AppLifecycleState.paused && msg.id != GlobalStore.user.id) {
        NotificationCenterListener.setListener(NotificationModel()
          ..type = NotificationType.SelfChat.enumToString
          ..id = msg.hashCode
          ..title = msg.topic
          ..msg = msg.msg);
      }
      msgs.add(msg);
      onScrollBottom();
      if (mounted) {
        setState(() {});
      }
    });
    _node.addListener(() {
      if (_node.hasFocus) {
        onScrollBottom();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _state = state;
    if (mounted) {
      setState(() {});
    }
  }

  void onScrollBottom() {
    Future<void>.delayed(const Duration(milliseconds: 500)).then((value) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
            _scrollController?.position?.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutQuart);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: RepaintBoundary(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: ListView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: msgs?.map((MessageModel e) {
                        return ChatMessage(
                          msg: e,
                        );
                      })?.toList() ??
                      [],
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  //底部组件
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () {
                  ToastUtils.showToast(msg: '暂未上线，敬请期待');
                }),
          ),
          Flexible(
            child: TextField(
              controller: _textEditingController,
              focusNode: _node,
              onChanged: (String text) {
                setState(() {
                  isComposer = text.isNotEmpty;
                });
              },
              decoration: const InputDecoration.collapsed(
                  hintText: '发送消息',
                  hintStyle: TextStyle(fontSize: 14, color: Colors.black12)),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: isComposer ? Colors.blueAccent : null,
              ),
              onPressed: () => isComposer
                  ? _handleSubmitted(_textEditingController.text)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  //删除聊天框里的消息并发送
  Future<void> _handleSubmitted(String text) async {
    _textEditingController.clear();
    setState(() {
      isComposer = false;
    });
    final MessageModel model = MessageModel()
      ..id = GlobalStore.user.id
      ..topic = widget.topic
      ..msg = text
      ..type = 'text'
      ..time = DateTimeHelper.getLocalTimeStamp();

    sendMsg(json.encode(model));
  }

  @override
  String get topic => widget.topic;
}

//消息
class ChatMessage extends StatefulWidget {
  const ChatMessage({this.msg});

  final MessageModel msg;

  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  User user = User();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUser();
  }

  void getUser() async {
    user = await UserCache().getCache(widget.msg.id);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.only(
        left: screenUtil.adaptive(20),
        right: screenUtil.adaptive(20),
      ),
      child: row(context),
    );
  }

  Widget row(BuildContext context) {
    if (widget.msg.id == GlobalStore.user?.id) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(user?.name ?? ''),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: widget.msg.sendImage != null &&
                          widget.msg.sendImage.isNotEmpty == true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageZoomable(
                                  photoList: [
                                    NetworkImage(widget.msg.sendImage)
                                  ],
                                  index: 0,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            widget.msg.sendImage,
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            color: Colors.green,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            child: Text(
                              widget.msg.msg ?? '',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          if (user != null && user.image?.isNotEmpty == true)
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user?.image ?? ''),
              ),
            ),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (user != null && user.image?.isNotEmpty == true)
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user?.image ?? ''),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(user?.name ?? ''),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: widget.msg.sendImage != null &&
                          widget.msg.sendImage.isNotEmpty == true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImageZoomable(
                                  photoList: [
                                    NetworkImage(widget.msg.sendImage)
                                  ],
                                  index: 0,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            widget.msg.sendImage,
                            width: 150.0,
                            height: 150.0,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            child: Text(
                              widget.msg.msg ?? '',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
