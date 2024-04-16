import 'package:json_annotation/json_annotation.dart';

part 'InfoEntity.g.dart';
/// [avatarUrl] 头像
/// [nickname] 呢称
/// [followStatus] 1=已关注 0=未关注
/// [userId] 用户id
@JsonSerializable()
class InfoEntity extends Object {
  String nickname;

  String avatarUrl;

  String? followStatus;

  String? userId;

  InfoEntity(
    this.nickname,
    this.avatarUrl,
    this.followStatus,
    this.userId,
  );

  factory InfoEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$InfoEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InfoEntityToJson(this);
}
