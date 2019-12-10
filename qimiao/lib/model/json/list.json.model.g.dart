// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListJsonMode _$ListJsonModeFromJson(Map<String, dynamic> json) {
  return ListJsonMode(json['list'] as List, json['total'] as int,
      json['numIndex'] as int, json['numSize'] as int);
}

Map<String, dynamic> _$ListJsonModeToJson(ListJsonMode instance) =>
    <String, dynamic>{
      'list': instance.list,
      'total': instance.total,
      'numIndex': instance.numIndex,
      'numSize': instance.numSize
    };
