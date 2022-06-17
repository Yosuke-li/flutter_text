import 'package:json_annotation/json_annotation.dart';

part 'symbol_info.g.dart';


@JsonSerializable()
class SymbolInfo extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'symbolEn')
  String symbolEn;

  @JsonKey(name: 'symbolCn')
  String symbolCn;

  @JsonKey(name: 'digits')
  int digits;

  @JsonKey(name: 'stopsLevel')
  int stopsLevel;

  @JsonKey(name: 'gtcPendings')
  int gtcPendings;

  @JsonKey(name: 'contractSize')
  double contractSize;

  @JsonKey(name: 'profitMode')
  int profitMode;

  @JsonKey(name: 'groupType')
  String groupType;

  @JsonKey(name: 'lever')
  int lever;

  @JsonKey(name: 'maxLever')
  int maxLever;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'minVolume')
  double minVolume;

  @JsonKey(name: 'createdAt')
  int createdAt;

  @JsonKey(name: 'updatedAt')
  int updatedAt;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'isDel')
  int isDel;

  @JsonKey(name: 'accType')
  int accType;

  @JsonKey(name: 'maxVolume')
  double maxVolume;

  @JsonKey(name: 'commission')
  double commission;

  @JsonKey(name: 'interest')
  double interest;

  @JsonKey(name: 'priceTick')
  double priceTick;

  SymbolInfo(this.id,this.symbolEn,this.symbolCn,this.digits,this.stopsLevel,this.gtcPendings,this.contractSize,this.profitMode,this.groupType,this.lever,this.maxLever,this.type,this.minVolume,this.createdAt,this.updatedAt,this.status,this.isDel,this.accType,this.maxVolume,this.commission,this.interest,this.priceTick,);

  factory SymbolInfo.fromJson(Map<String, dynamic> srcJson) => _$SymbolInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SymbolInfoToJson(this);

  static List<SymbolInfo> listFromJson(List<dynamic>? json) {
    return json == null
        ? <SymbolInfo>[]
        : json.map((e) => SymbolInfo.fromJson(e)).toList();
  }

}


