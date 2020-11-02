// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetRecord _$PetRecordFromJson(Map<String, dynamic> json) {
  return PetRecord(
    json['pet_id'] as int,
    json['user_id'] as int,
    json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    json['result'] as String,
    json['image_uuid'] as String,
  );
}

Map<String, dynamic> _$PetRecordToJson(PetRecord instance) => <String, dynamic>{
      'pet_id': instance.petId,
      'user_id': instance.userId,
      'timestamp': instance.timestamp?.toIso8601String(),
      'result': instance.result,
      'image_uuid': instance.imageUuid,
    };
