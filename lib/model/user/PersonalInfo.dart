import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/chat/CheckMessage.dart';

part 'PersonalInfo.g.dart';

/// [userId] 用户id
/// [nickname] 用户名称
/// [avatarUrl] 头像
/// [sex] 性别
/// [age] 年龄
/// [distance] 距离公里数
/// [authStatus] 是否实名认证 0=未实名 1=已实名
/// [introduction] 简介
/// [appearanceHighNumber] 高颜值总和
/// [appearanceLowNumber] 傻呆呆总和
/// [appearanceStatus] 0=未点赞过  1=高颜值 2=傻呆呆
/// [friendStatus] 是否好友  1=否 2=是
/// [balance] 余额  仅自己可见

@JsonSerializable()
class PersonalInfo extends Object {
  int userId;

  String nickname;

  String avatarUrl;

  int sex;

  int age;

  String? distance;

  int authStatus;

  String introduction;

  int? appearanceHighNumber;

  int? appearanceLowNumber;

  int? appearanceStatus;

  int? friendStatus;

  double? balance;

  PersonalInfo(
    this.userId,
    this.nickname,
    this.avatarUrl,
    this.sex,
    this.age,
    this.distance,
    this.authStatus,
    this.introduction,
    this.appearanceHighNumber,
    this.appearanceLowNumber,
    this.appearanceStatus,
    this.friendStatus,
    this.balance,
  );

  factory PersonalInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonalInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonalInfoToJson(this);
}
