/// id : 0
/// name : ""
/// toId : 1
/// msg : "asdasd"
/// image : "sds"
/// topic : ""
/// type : "room"

class MessageModel {
  int id;
  String name;
  int toId;
  String msg;
  String image;
  String topic;
  String type;

  MessageModel({
      int id, 
      String name, 
      int toId, 
      String msg, 
      String image, 
      String topic, 
      String type}){
    id = id;
    name = name;
    toId = toId;
    msg = msg;
    image = image;
    topic = topic;
    type = type;
}

  MessageModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    toId = json["toId"];
    msg = json["msg"];
    image = json["image"];
    topic = json["topic"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["toId"] = toId;
    map["msg"] = msg;
    map["image"] = image;
    map["topic"] = topic;
    map["type"] = type;
    return map;
  }

}