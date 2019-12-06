// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.json.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseJsonModel _$ResponseJsonModelFromJson(Map<String, dynamic> json) {
  return ResponseJsonModel(
      json['code'] as String, json['msg'] as String, json['data']);
}

Map<String, dynamic> _$ResponseJsonModelToJson(ResponseJsonModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };
