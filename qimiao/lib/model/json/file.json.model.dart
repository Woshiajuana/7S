
import 'package:json_annotation/json_annotation.dart';

// json.g.dart 将在我们运行生成命令后自动生成
part 'file.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class FileJsonModel {
  FileJsonModel(
    this.user,
    this.ip,
    this.type,
    this.path,
    this.base,
    this.filename,
    this.device,
    this.source,
  );

  @JsonKey(name: 'user')
  String user;

  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'path')
  String path;

  @JsonKey(name: 'base')
  String base;

  @JsonKey(name: 'filename')
  String filename;

  @JsonKey(name: 'device')
  String device;

  @JsonKey(name: 'source')
  String source;

  //不同的类使用不同的mixin即可
  factory FileJsonModel.fromJson(Map<String, dynamic> json) => _$FileJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileJsonModelToJson(this);

  // 命名构造函数
  FileJsonModel.empty();
}