class MusicModel {
  String name;
  String id;
  String title;

  MusicModel({this.name, this.title, this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['name'] = name;
    map['title'] = title;
    map['id'] = id;

    return map;
  }

  //todo Uint8List.fromList((json['book'] as List<dynamic>).cast<int>().toList());
  MusicModel.fromJson(dynamic json) {
    name = json['name'];
    title = json['title'];
    id = json['id'];
  }

  @override
  String toString() {
    return 'MusicModel[name=$name, title=$title, id=$id]';
  }

  static List<MusicModel> listFromJson(List<dynamic> json) {
    return json == null
        ? <MusicModel>[]
        : json.map((e) => MusicModel.fromJson(e)).toList();
  }
}
