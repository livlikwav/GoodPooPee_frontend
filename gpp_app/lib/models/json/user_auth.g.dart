// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) {
  return UserAuth(
    json['access_token'] as String,
    json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    json['pet'] == null
        ? null
        : PetModel.fromJson(json['pet'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserAuthToJson(UserAuth instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'user': instance.user,
      'pet': instance.pet,
    };
