// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectJsonModel _$CollectJsonModelFromJson(Map<String, dynamic> json) {
  return CollectJsonModel(
      json['_id'] as String,
      json['photo'] == null
          ? null
          : PhotoJsonModel.fromJson(json['photo'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : UserJsonModel.fromJson(json['user'] as Map<String, dynamic>),
      json['created_at'] as String);
}

Map<String, dynamic> _$CollectJsonModelToJson(CollectJsonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'photo': instance.photo,
      'created_at': instance.created_at
    };
