import 'package:json_annotation/json_annotation.dart';

import 'MsgInfo.dart';

part 'SystemMsg.g.dart';

/// [id] id
/// [userId] 用户id
/// [readFlag] 是否已读 1=未读 2=已读
/// [msgInfo] 消息
/// [createTime] 创建时间
@JsonSerializable()
class SystemMsg extends Object {
  int id;
  int userId;
  int readFlag;
  MsgInfo msgInfo;
  String createTime;

  SystemMsg(
    this.id,
    this.userId,
    this.readFlag,
    this.msgInfo,
    this.createTime,
  );

  factory SystemMsg.fromJson(Map<String, dynamic> srcJson) =>
      _$SystemMsgFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SystemMsgToJson(this);
}
