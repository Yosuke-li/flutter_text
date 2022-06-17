import 'package:json_annotation/json_annotation.dart';

part 'scratch_model.g.dart';


@JsonSerializable()
class ScratchModel extends Object {

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'price')
  num price;

  @JsonKey(name: 'side')
  num side;

  @JsonKey(name: 'range')
  num range;

  @JsonKey(name: 'updateTime')
  num updateTime;

  @JsonKey(name: 'up')
  bool up;

  @JsonKey(name: 'isUpdate')
  bool? isUpdate;

  ScratchModel(this.title,this.id,this.price,this.side,this.range,this.updateTime,this.up,this.isUpdate);

  factory ScratchModel.fromJson(Map<String, dynamic> srcJson) => _$ScratchModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ScratchModelToJson(this);

  static List<ScratchModel> listFromJson(List<dynamic>? json) {
    return json == null
        ? <ScratchModel>[]
        : json.map((e) => ScratchModel.fromJson(e)).toList();
  }
}


