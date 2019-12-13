// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeJsonModel _$NoticeJsonModelFromJson(Map<String, dynamic> json) {
  return NoticeJsonModel(
      json['_id'] as String,
      json['title'] as String,
      json['nature'] as String,
      json['type'] as String,
      json['content'] as String,
      json['unread'] as bool,
      json['push'] as bool,
      json['created_at'] as String,
      json['updated_at'] as String);
}

Map<String, dynamic> _$NoticeJsonModelToJson(NoticeJsonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'nature': instance.nature,
      'type': instance.type,
      'content': instance.content,
      'unread': instance.unread,
      'push': instance.push,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at
    };
