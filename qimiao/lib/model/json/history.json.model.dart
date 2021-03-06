
import 'package:json_annotation/json_annotation.dart';
import 'photo.json.model.dart';
import 'user.json.model.dart';

// json.g.dart 将在我们运行生成命令后自动生成
part 'history.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class HistoryJsonModel {
  HistoryJsonModel(
    this.id,
    this.photo,
    this.user,
    this.created_at,
  );

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'user')
  UserJsonModel user;

  @JsonKey(name: 'photo')
  PhotoJsonModel photo;


  @JsonKey(name: 'created_at')
  String created_at;

  //不同的类使用不同的mixin即可
  factory HistoryJsonModel.fromJson(Map<String, dynamic> json) => _$HistoryJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryJsonModelToJson(this);

  // 命名构造函数
  HistoryJsonModel.empty();
}