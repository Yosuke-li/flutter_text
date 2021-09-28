class SqlUser {
  SqlUser();

  int _id;
  String _name;
  String _desc;

  int get id => _id;

  String get name => _name;

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;

    return map;
  }

  SqlUser.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _desc = map['desc'];
  }

  String toString() {
    return 'User[id=$id, name=$name, desc=$desc]';
  }

  SqlUser.fromJson(Map<String, dynamic> json) {
    if (json == null || json?.keys.isNotEmpty != true) return;
    final Map<String, dynamic> keyToLowerCaseJson = {};
    keyToLowerCaseJson.addEntries(json.keys.map((element) {
      final String key = element;
      return MapEntry(key.toLowerCase(), json[element]);
    }));
    SqlUser.fromMapObject(keyToLowerCaseJson);
  }

  static List<SqlUser> listFromJson(List<dynamic> json) {
    return json == null
        ? <SqlUser>[]
        : json.map((e) => SqlUser.fromJson(e)).toList();
  }
}
