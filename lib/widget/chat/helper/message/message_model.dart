/// id : 0
/// name : ''
/// toId : 1
/// msg : 'asdasd'
/// sendImage : 'sds'
/// topic : ''
/// type : 'room'

class MessageModel {
  int? id;
  int? toId;
  String? msg;
  String? sendImage;
  String? topic;
  String? type;
  int? time;

  MessageModel(){
    id = id;
    toId = toId;
    msg = msg;
    time = time;
    sendImage = sendImage;
    topic = topic;
    type = type;
}

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    toId = json['toId'];
    msg = json['msg'];
    time = json['time'];
    sendImage = json['sendImage'];
    topic = json['topic'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['toId'] = toId;
    map['msg'] = msg;
    map['time'] = time;
    map['sendImage'] = sendImage;
    map['topic'] = topic;
    map['type'] = type;
    return map;
  }

}