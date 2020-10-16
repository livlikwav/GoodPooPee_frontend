// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetModel _$PetModelFromJson(Map<String, dynamic> json) {
  return PetModel(
    json['id'] as int,
    json['name'] as String,
    json['breed'] as String,
    json['birth'] == null ? null : DateTime.parse(json['birth'] as String),
    json['adoption'] == null
        ? null
        : DateTime.parse(json['adoption'] as String),
  );
}

Map<String, dynamic> _$PetModelToJson(PetModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'breed': instance.breed,
      'birth': instance.birth?.toIso8601String(),
      'adoption': instance.adoption?.toIso8601String(),
    };
