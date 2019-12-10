
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'list.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class ListJsonMode {
  ListJsonMode(
    this.list,
    this.total,
    this.numIndex,
    this.numSize,
  );

  @JsonKey(name: 'list')
  List list;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'numIndex')
  int numIndex;

  @JsonKey(name: 'numSize')
  int numSize;

  //不同的类使用不同的mixin即可
  factory ListJsonMode.fromJson(Map<String, dynamic> json) => _$ListJsonModeFromJson(json);

  Map<String, dynamic> toJson() => _$ListJsonModeToJson(this);

  // 命名构造函数
  ListJsonMode.empty();
}