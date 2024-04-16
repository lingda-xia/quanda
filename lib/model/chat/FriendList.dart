import 'package:json_annotation/json_annotation.dart';

part 'FriendList.g.dart';

/// [toUserId] id
/// [remarkName] 备注
/// [toDesc] 描述(指我对好友的描述)
/// [avatarUrl] 头像
/// [tagId] 标签id
/// [name] 标签名
/// [indexLetter] 组头

@JsonSerializable()
class FriendList extends Object {
  int toUserId;

  String remarkName;

  String? toDesc;

  String avatarUrl;

  String? tagId;

  String? name;

  String indexLetter;

  FriendList(
    this.toUserId,
    this.remarkName,
    this.toDesc,
    this.avatarUrl,
    this.tagId,
    this.name,
    this.indexLetter,
  );

  factory FriendList.fromJson(Map<String, dynamic> srcJson) =>
      _$FriendListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FriendListToJson(this);
}
