
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'notice.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class NoticeJsonModel {
  NoticeJsonModel(
    this.title,
    this.nature,
    this.type,
    this.content,
    this.unread,
    this.push,
    this.created_at,
    this.updated_at,
  );

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'nature')
  String nature;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'unread')
  String unread;

  @JsonKey(name: 'push')
  String push;

  @JsonKey(name: 'created_at')
  String created_at;

  @JsonKey(name: 'updated_at')
  String updated_at;

  //不同的类使用不同的mixin即可
  factory NoticeJsonModel.fromJson(Map<String, dynamic> json) => _$NoticeJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeJsonModelToJson(this);

  // 命名构造函数
  NoticeJsonModel.empty();
}