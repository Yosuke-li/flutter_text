/// id : 0
/// name : ''
/// toId : 1
/// msg : 'asdasd'
/// sendImage : 'sds'
/// topic : ''
/// type : 'room'

class MessageModel {
  int id;
  String name;
  int toId;
  String msg;
  String sendImage;
  String topic;
  String headImage;
  String type;
  int time;

  MessageModel({
      int id, 
      String name, 
      int toId, 
      String msg, 
      String sendImage, 
      String headImage,
      String topic,
      int time,
      String type}){
    id = id;
    name = name;
    toId = toId;
    msg = msg;
    time = time;
    sendImage = sendImage;
    headImage = headImage;
    topic = topic;
    type = type;
}

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    toId = json['toId'];
    msg = json['msg'];
    time = json['time'];
    headImage = json['headImage'];
    sendImage = json['sendImage'];
    topic = json['topic'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['toId'] = toId;
    map['msg'] = msg;
    map['time'] = time;
    map['headImage'] = headImage;
    map['sendImage'] = sendImage;
    map['topic'] = topic;
    map['type'] = type;
    return map;
  }

}