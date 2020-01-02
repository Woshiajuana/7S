// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionJsonModel _$VersionJsonModelFromJson(Map<String, dynamic> json) {
  return VersionJsonModel(
      json['_id'] as String,
      json['version'] as String,
      json['platform'] as String,
      json['remark'] as String,
      json['min'] as bool,
      json['max'] as bool,
      json['address'] as String,
      json['content'] as List,
      json['minVersion'] as String,
      json['created_at'] as String);
}

Map<String, dynamic> _$VersionJsonModelToJson(VersionJsonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'version': instance.version,
      'platform': instance.platform,
      'remark': instance.remark,
      'min': instance.min,
      'max': instance.max,
      'address': instance.address,
      'minVersion': instance.minVersion,
      'content': instance.content,
      'created_at': instance.created_at
    };
