// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymbolInfo _$SymbolInfoFromJson(Map<String, dynamic> json) => SymbolInfo(
      json['id'] as int,
      json['symbolEn'] as String,
      json['symbolCn'] as String,
      json['digits'] as int,
      json['stopsLevel'] as int,
      json['gtcPendings'] as int,
      (json['contractSize'] as num).toDouble(),
      json['profitMode'] as int,
      json['groupType'] as String,
      json['lever'] as int,
      json['maxLever'] as int,
      json['type'] as int,
      (json['minVolume'] as num).toDouble(),
      json['createdAt'] as int,
      json['updatedAt'] as int,
      json['status'] as int,
      json['isDel'] as int,
      json['accType'] as int,
      (json['maxVolume'] as num).toDouble(),
      (json['commission'] as num).toDouble(),
      (json['interest'] as num).toDouble(),
      (json['priceTick'] as num).toDouble(),
    );

Map<String, dynamic> _$SymbolInfoToJson(SymbolInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbolEn': instance.symbolEn,
      'symbolCn': instance.symbolCn,
      'digits': instance.digits,
      'stopsLevel': instance.stopsLevel,
      'gtcPendings': instance.gtcPendings,
      'contractSize': instance.contractSize,
      'profitMode': instance.profitMode,
      'groupType': instance.groupType,
      'lever': instance.lever,
      'maxLever': instance.maxLever,
      'type': instance.type,
      'minVolume': instance.minVolume,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
      'isDel': instance.isDel,
      'accType': instance.accType,
      'maxVolume': instance.maxVolume,
      'commission': instance.commission,
      'interest': instance.interest,
      'priceTick': instance.priceTick,
    };
