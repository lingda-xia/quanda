import 'package:json_annotation/json_annotation.dart';

part 'LabelEntity.g.dart';

/// [id] id
/// [userId] 用户id
/// [name] 名称
/// [tagFriendName] 标签内名字
/// [friendCount] 标签好友总数量

@JsonSerializable()
class LabelEntity extends Object {
  int id;

  int userId;

  String name;

  String tagFriendName;

  int friendCount;

  LabelEntity(
    this.id,
    this.userId,
    this.name,
    this.tagFriendName,
    this.friendCount,
  );

  factory LabelEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$LabelEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LabelEntityToJson(this);
}
