// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymbolModel _$SymbolModelFromJson(Map<String, dynamic> json) => SymbolModel(
      SymbolInfo.fromJson(json['symbolInfo'] as Map<String, dynamic>),
      json['lastPrice'] as int,
      json['preSettlementPrice'] as int,
    );

Map<String, dynamic> _$SymbolModelToJson(SymbolModel instance) =>
    <String, dynamic>{
      'symbolInfo': instance.symbolInfo,
      'lastPrice': instance.lastPrice,
      'preSettlementPrice': instance.preSettlementPrice,
    };
