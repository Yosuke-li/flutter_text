/// id : 123
/// name : 'coco'
/// image : 'https://...'
/// createTime : 1202151321
/// updateTime : 1203551322

class User {
  int id;
  String name;
  String image;
  int createTime;
  int updateTime;

  User({this.id, this.name, this.image, this.createTime, this.updateTime});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    createTime = json['createtime'];
    updateTime = json['updatetime'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['createTime'] = createTime;
    map['updateTime'] = updateTime;
    return map;
  }

  static List<User> listFromJson(List<dynamic> json) {
    return json == null
        ? <User>[]
        : json.map((e) => User.fromJson(e)).toList();
  }
}
