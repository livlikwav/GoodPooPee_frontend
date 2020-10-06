// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) {
  return UserAuth(
    json['access_token'] as String,
    json['user_id'] as int,
    json['pet_id'] as int,
    json['ppcam_id'] as int,
  );
}

Map<String, dynamic> _$UserAuthToJson(UserAuth instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'user_id': instance.user_id,
      'pet_id': instance.pet_id,
      'ppcam_id': instance.ppcam_id,
    };
