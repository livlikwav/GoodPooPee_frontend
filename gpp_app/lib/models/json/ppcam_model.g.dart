// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppcam_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PpcamModel _$PpcamModelFromJson(Map<String, dynamic> json) {
  return PpcamModel(
    json['user_id'] as int,
    json['id'] as int,
    json['serial_num'] as String,
    json['ip_address'] as String,
  );
}

Map<String, dynamic> _$PpcamModelToJson(PpcamModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'id': instance.id,
      'serial_num': instance.serialNum,
      'ip_address': instance.ipAddress,
    };
