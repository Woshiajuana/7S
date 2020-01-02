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
    ..id = json['_id'] as String
    ..user = json['user'] == null
        ? null
        : UserJsonModel.fromJson(json['user'] as Map<String, dynamic>)
    ..numThumb = json['numThumb'] as int
    ..dislike = json['dislike'] as int
    ..numCollect = json['numCollect'] as int
    ..thumbId = json['thumbId'] as String
    ..dislikeId = json['dislikeId'] as String
    ..collectId = json['collectId'] as String;
}

Map<String, dynamic> _$PhotoJsonModelToJson(PhotoJsonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'photo': instance.photo,
      'title': instance.title,
      'volume': instance.volume,
      'nature': instance.nature,
      'numThumb': instance.numThumb,
      'dislike': instance.dislike,
      'numCollect': instance.numCollect,
      'thumbId': instance.thumbId,
      'dislikeId': instance.dislikeId,
      'collectId': instance.collectId,
      'created_at': instance.created_at
    };
