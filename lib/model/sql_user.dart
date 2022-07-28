class SqlUser {
  SqlUser({this.id, this.name, this.desc});

  int? id;
  String? name;
  String? desc;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['desc'] = desc;

    return map;
  }

  SqlUser.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    desc = map['desc'];
  }

  SqlUser.fromJson(Map<String, dynamic>? json) {
    if (json == null || json.keys.isNotEmpty != true) return;
    final Map<String, dynamic> keyToLowerCaseJson = {};
    keyToLowerCaseJson.addEntries(json.keys.map((element) {
      final String key = element;
      return MapEntry(key.toLowerCase(), json[element]);
    }));
    SqlUser.fromMapObject(keyToLowerCaseJson);
  }

  static List<SqlUser> listFromJson(List<dynamic>? json) {
    return json == null
        ? <SqlUser>[]
        : json.map((e) => SqlUser.fromJson(e)).toList();
  }
}
