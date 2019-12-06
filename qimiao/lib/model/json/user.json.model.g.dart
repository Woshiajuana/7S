// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJsonModel _$UserJsonModelFromJson(Map<String, dynamic> json) {
  return UserJsonModel(
      json['phone'] as String,
      json['nickname'] as String,
      json['avatar'] as String,
      json['sex'] as String,
      json['email'] as String,
      json['numVideo'] as int,
      json['numPhoto'] as int,
      json['numFollower'] as int,
      json['numFollowing'] as int,
      json['numPrivateNotice'] as int,
      json['numPublicNotice'] as int);
}

Map<String, dynamic> _$UserJsonModelToJson(UserJsonModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'sex': instance.sex,
      'email': instance.email,
      'numVideo': instance.numVideo,
      'numPhoto': instance.numPhoto,
      'numFollower': instance.numFollower,
      'numFollowing': instance.numFollowing,
      'numPrivateNotice': instance.numPrivateNotice,
      'numPublicNotice': instance.numPublicNotice
    };
