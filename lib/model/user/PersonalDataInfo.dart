import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';

part 'PersonalDataInfo.g.dart';

/// [userId] 用户id
/// [nickname] 呢称
/// [authStatus] 0=未认证 1=已认证
/// [sex] 1=男 2=女
/// [age] 年龄
/// [birthday] 生日
/// [introduction] 简介
/// [avatarUrl] 头像
/// [addressInfo] 收货地址信息
/// [authInfo] 认证信息
@JsonSerializable()
class PersonalDataInfo extends Object {
  int userId;
  String nickname;
  int authStatus;
  int sex;
  int age;
  String birthday;
  String introduction;
  String avatarUrl;
  ReceivingEntity? addressInfo;
  Map<String, String> authInfo;

  PersonalDataInfo(
    this.userId,
    this.nickname,
    this.authStatus,
    this.sex,
    this.age,
    this.birthday,
    this.introduction,
    this.avatarUrl,
    this.addressInfo,
    this.authInfo,
  );

  factory PersonalDataInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$PersonalDataInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PersonalDataInfoToJson(this);
}
