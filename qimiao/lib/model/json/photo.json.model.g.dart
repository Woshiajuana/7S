// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoJsonModel _$PhotoJsonModelFromJson(Map<String, dynamic> json) {
  return PhotoJsonModel(
      json['photo'] == null
          ? null
          : FileJsonModel.fromJson(json['photo'] as Map<String, dynamic>),
      json['title'] as String,
      json['volume'] as int,
      json['nature'] as String,
      json['created_at'] as String)
    ..id = json['_id'] as String;
}

Map<String, dynamic> _$PhotoJsonModelToJson(PhotoJsonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'photo': instance.photo,
      'title': instance.title,
      'volume': instance.volume,
      'nature': instance.nature,
      'created_at': instance.created_at
    };
