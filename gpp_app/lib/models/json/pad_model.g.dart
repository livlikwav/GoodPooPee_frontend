// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PadModel _$PadModelFromJson(Map<String, dynamic> json) {
  return PadModel(
    json['id'] as int,
    (json['lux'] as num)?.toDouble(),
    (json['luy'] as num)?.toDouble(),
    (json['ldx'] as num)?.toDouble(),
    (json['ldy'] as num)?.toDouble(),
    (json['rdx'] as num)?.toDouble(),
    (json['rdy'] as num)?.toDouble(),
    (json['rux'] as num)?.toDouble(),
    (json['ruy'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PadModelToJson(PadModel instance) => <String, dynamic>{
      'id': instance.id,
      'lux': instance.lux,
      'luy': instance.luy,
      'ldx': instance.ldx,
      'ldy': instance.ldy,
      'rdx': instance.rdx,
      'rdy': instance.rdy,
      'rux': instance.rux,
      'ruy': instance.ruy,
    };
