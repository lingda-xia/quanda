import 'package:json_annotation/json_annotation.dart';

part 'SearchEntity.g.dart';

/// [userId] id
/// [nickname] 我的用户id
/// [avatarUrl] 对方的用户id
/// [toDesc] 内容
/// [friendStatus] 是否好友  0=否 1=是
/// [introduction] 名称
/// [remarkName] 名称

@JsonSerializable()
class SearchEntity extends Object {
  String userId;

  String nickname;

  String avatarUrl;

  String toDesc;

  bool friendStatus;

  String introduction;

  String remarkName;

  SearchEntity(
      this.userId,
      this.nickname,
      this.avatarUrl,
      this.toDesc,
      this.friendStatus,
      this.introduction,
      this.remarkName,
      );

  factory SearchEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchEntityToJson(this);
}
