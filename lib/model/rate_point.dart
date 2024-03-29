class RatePoint extends Object {
  String kind;
  double dx;
  double dy;

  RatePoint(this.kind, this.dx, this.dy);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['kind'] = kind;
    map['dx'] = dx;
    map['dy'] = dy;

    return map;
  }

  factory RatePoint.fromJson(Map<String, dynamic> json) {
    return RatePoint(
        json['kind'] as String, json['dx'] as double, json['dy'] as double);
  }

  Map<String, dynamic> toJson() => _RatePointToJson(this);

  Map<String, dynamic> _RatePointToJson(value) {
    return <String, dynamic>{
      'kind': value.kind,
      'dx': value.dx,
      'dy': value.dy
    };
  }

  static List<RatePoint> listFromJson(List<dynamic>? json) {
    return json == null
        ? <RatePoint>[]
        : json.map((e) => RatePoint.fromJson(e)).toList();
  }
}
