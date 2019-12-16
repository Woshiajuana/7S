// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileJsonModel _$FileJsonModelFromJson(Map<String, dynamic> json) {
  return FileJsonModel(
      json['user'] as String,
      json['ip'] as String,
      json['type'] as String,
      json['path'] as String,
      json['base'] as String,
      json['filename'] as String,
      json['device'] as String,
      json['source'] as String);
}

Map<String, dynamic> _$FileJsonModelToJson(FileJsonModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'ip': instance.ip,
      'type': instance.type,
      'path': instance.path,
      'base': instance.base,
      'filename': instance.filename,
      'device': instance.device,
      'source': instance.source
    };
