import 'package:json_annotation/json_annotation.dart';

part 'FollowEntity.g.dart';

/// [id] id
/// [userId] 用户id
/// [sellUserId] 被关注人的id
/// [followStatus] 0=未关注 1=已关注
/// [nickname] 名称
/// [avatarUrl] 头像
@JsonSerializable()
class FollowEntity extends Object {
  int id;
  int userId;
  int sellUserId;
  int followStatus;
  String nickname;
  String avatarUrl;

  FollowEntity(
    this.id,
    this.userId,
    this.sellUserId,
    this.followStatus,
    this.nickname,
    this.avatarUrl,
  );

  factory FollowEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$FollowEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FollowEntityToJson(this);
}
