class User {
  User();

  int? _id;
  String? _name;
  String? _desc;
  String? _image;

  int? get id => _id;

  String? get name => _name;

  String? get desc => _desc;

  String? get image => _image;

  set desc(String? value) {
    _desc = value;
  }

  set name(String? value) {
    _name = value;
  }

  set id(int? value) {
    _id = value;
  }

  set image(String? value) {
    _image = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
    map['image'] = _image;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._desc = map['desc'];
    this._image = map['image'];
  }

  String toString() {
    return 'User[id=$id, name=$name, desc=$desc, image=$image]';
  }

  User.fromJson(Map<String, dynamic> json) {
    if (json == null || json.keys.isNotEmpty != true) return;
    final Map<String, dynamic> keyToLowerCaseJson = {};
    keyToLowerCaseJson.addEntries(json.keys.map((element) {
      final String key = element;
      return MapEntry(key.toLowerCase(), json[element]);
    }));
    User.fromMapObject(keyToLowerCaseJson);
  }

  static List<User> listFromJson(List<dynamic> json) {
    return json == null
        ? <User>[]
        : json.map((e) => User.fromJson(e)).toList();
  }
}
