import 'package:json_annotation/json_annotation.dart';

part 'CheckMessage.g.dart';

/// [id] id
/// [userId] 我的用户id
/// [toUserId] 对方的用户id
/// [content] 内容
/// [name] 名称

@JsonSerializable()
class CheckMessage extends Object {
  int id;

  int userId;

  int toUserId;

  String content;

  String name;

  CheckMessage(
    this.id,
    this.userId,
    this.toUserId,
    this.content,
    this.name,
  );

  factory CheckMessage.fromJson(Map<String, dynamic> srcJson) =>
      _$CheckMessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckMessageToJson(this);
}
