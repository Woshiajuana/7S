
import 'package:json_annotation/json_annotation.dart';
import 'file.json.model.dart';

// json.g.dart 将在我们运行生成命令后自动生成
part 'photo.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class PhotoJsonModel {
  PhotoJsonModel(
    this.photo,
    this.title,
    this.nature,
  );

  @JsonKey(name: 'photo')
  FileJsonModel photo;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'nature')
  String nature;

  //不同的类使用不同的mixin即可
  factory PhotoJsonModel.fromJson(Map<String, dynamic> json) => _$PhotoJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoJsonModelToJson(this);

  // 命名构造函数
  PhotoJsonModel.empty();
}