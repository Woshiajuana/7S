
import 'package:json_annotation/json_annotation.dart';

// json.g.dart 将在我们运行生成命令后自动生成
part 'version.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class VersionJsonModel {
  VersionJsonModel(
    this.id,
    this.version,
    this.platform,
    this.remark,
    this.min,
    this.max,
    this.address,
    this.content,
    this.minVersion,
    this.created_at,
  );

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'platform')
  String platform;

  @JsonKey(name: 'remark')
  String remark;

  @JsonKey(name: 'min')
  bool min;

  @JsonKey(name: 'max')
  bool max;

  @JsonKey(name: 'address')
  String address;

  @JsonKey(name: 'minVersion')
  String minVersion;

  @JsonKey(name: 'content')
  List content;

  @JsonKey(name: 'created_at')
  String created_at;

  //不同的类使用不同的mixin即可
  factory VersionJsonModel.fromJson(Map<String, dynamic> json) => _$VersionJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$VersionJsonModelToJson(this);

  // 命名构造函数
  VersionJsonModel.empty();
}