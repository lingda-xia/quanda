import 'package:json_annotation/json_annotation.dart';

part 'NoticeEntity.g.dart';

/// [msgCount] 未读消息总数
/// [info] 最新最后一条消息
/// [createTime] 添加时间
@JsonSerializable()
class NoticeEntity extends Object {
  int msgCount;

  String info;

  String? createTime;

  NoticeEntity(
    this.msgCount,
    this.info,
    this.createTime,
  );

  factory NoticeEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$NoticeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NoticeEntityToJson(this);
}
