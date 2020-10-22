// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadModel _$PadModelFromJson(Map<String, dynamic> json) {
  return PadModel(
    json['id'] as int,
    json['ldx'] as int,
    json['ldy'] as int,
    json['lux'] as int,
    json['luy'] as int,
    json['rdx'] as int,
    json['rdy'] as int,
    json['rux'] as int,
    json['rdy'],
  )..ruy = json['ruy'] as int;
}

Map<String, dynamic> _$PadModelToJson(PadModel instance) => <String, dynamic>{
      'id': instance.id,
      'ldx': instance.ldx,
      'ldy': instance.ldy,
      'lux': instance.lux,
      'luy': instance.luy,
      'rdx': instance.rdx,
      'rdy': instance.rdy,
      'rux': instance.rux,
      'ruy': instance.ruy,
    };
