
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'user.json.model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()

class UserJsonModel {
  UserJsonModel(
    this.phone,
    this.nickname,
    this.avatar,
    this.sex,
    this.email,
  );

  @JsonKey(name: 'phone')
  String phone;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'sex')
  String sex;

  @JsonKey(name: 'email')
  String email;

  //不同的类使用不同的mixin即可
  factory UserJsonModel.fromJson(Map<String, dynamic> json) => _$UserJsonModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserJsonModelToJson(this);

  // 命名构造函数
  UserJsonModel.empty();
}