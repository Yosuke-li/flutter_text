import 'package:flutter_text/assembly_pack/scratchable/symbol_info.dart';
import 'package:json_annotation/json_annotation.dart';


part 'symbol.g.dart';


@JsonSerializable()
class SymbolModel extends Object {

  @JsonKey(name: 'symbolInfo')
  SymbolInfo symbolInfo;

  @JsonKey(name: 'lastPrice')
  int lastPrice;

  @JsonKey(name: 'preSettlementPrice')
  int preSettlementPrice;

  SymbolModel(this.symbolInfo,this.lastPrice,this.preSettlementPrice,);

  factory SymbolModel.fromJson(Map<String, dynamic> srcJson) => _$SymbolModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SymbolModelToJson(this);

}
