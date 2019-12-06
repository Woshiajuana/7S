
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'response.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class ResponseJsonModel {
  ResponseJsonModel(
    this.code,
    this.msg,
    this.data,
  );

  @JsonKey(name: 'code')
  String code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'data')
  dynamic data;

  //不同的类使用不同的mixin即可
  factory ResponseJsonModel.fromJson(Map<String, dynamic> json) => _$ResponseJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseJsonModelToJson(this);

  // 命名构造函数
  ResponseJsonModel.empty();
}