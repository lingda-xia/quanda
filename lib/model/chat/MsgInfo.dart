import 'package:json_annotation/json_annotation.dart';

part 'MsgInfo.g.dart';

/// [path] 消息地址
/// [msgType] 消息类型
/// [info] 消息内容
@JsonSerializable()
class MsgInfo extends Object {
  String path;
  String msgType;
  String info;

  MsgInfo(
    this.path,
    this.msgType,
    this.info,
  );

  factory MsgInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$MsgInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MsgInfoToJson(this);
}
