// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scratch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScratchModel _$scratchModelFromJson(Map<String, dynamic> json) => ScratchModel(
      json['title'] as String,
      json['id'] as String,
      json['price'] as num,
      json['side'] as num,
      json['range'] as num,
      json['updateTime'] as num,
      json['up'] as bool,
      json['isUpdate'] as bool?,
    );

Map<String, dynamic> _$scratchModelToJson(ScratchModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'price': instance.price,
      'side': instance.side,
      'range': instance.range,
      'updateTime': instance.updateTime,
      'up': instance.up,
      'isUpdate': instance.isUpdate,
    };
