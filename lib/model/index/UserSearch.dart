import 'package:json_annotation/json_annotation.dart';

part 'UserSearch.g.dart';

/// [userId] 用户id
/// [nickname] 名称
/// [introduction] 简介
/// [avatarUrl] 头像
/// [friendStatus] 是否好友  0=否 1=是

@JsonSerializable()
class UserSearch extends Object {
  String userId;

  String nickname;

  String introduction;

  String avatarUrl;

  String friendStatus;

  UserSearch(
    this.userId,
    this.nickname,
    this.introduction,
    this.avatarUrl,
    this.friendStatus,
  );

  factory UserSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$UserSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserSearchToJson(this);
}
