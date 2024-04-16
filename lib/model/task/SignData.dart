import 'package:json_annotation/json_annotation.dart';

part 'SignData.g.dart';

/// [id] id
/// [userId] 用户id
/// [money] 签到金额
/// [signTime] 签到时间戳(毫秒)
/// [status] 状态 1=未签到 2=已签到
@JsonSerializable()
class SignData extends Object {
  int id;

  int userId;

  double money;

  String signTime;

  int status;

  SignData(
    this.id,
    this.userId,
    this.money,
    this.signTime,
    this.status,
  );

  factory SignData.fromJson(Map<String, dynamic> srcJson) =>
      _$SignDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SignDataToJson(this);
}
