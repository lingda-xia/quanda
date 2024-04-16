import 'package:json_annotation/json_annotation.dart';

part 'PrivacyInfo.g.dart';

/// [qrcodeStatus] 二维码开启状态 0=关闭 1=开启
/// [nearbyStatus] 附近推荐是否开启  0=关闭 1=开启
/// [sexStatus] 是否隐藏性别 0=隐藏 1= 显示
/// [ageStatus] 是否隐藏年龄 0=隐藏 1=显示
/// [addressStatus] 是否显示地区 0=关闭 1=开启
/// [homeShareStatus] 个人主页是否允许分享 0=不允许 1=允许
/// [contentShareStatus] 内容是否允许分享 0=不允许 1=允许
/// [searchStatus] 搜索是否开启 0=关闭 1=开启
@JsonSerializable()
class PrivacyInfo extends Object {
  int qrcodeStatus;
  int nearbyStatus;
  int sexStatus;
  int ageStatus;
  int addressStatus;
  int homeShareStatus;
  int contentShareStatus;
  int searchStatus;

  PrivacyInfo(
    this.qrcodeStatus,
    this.nearbyStatus,
    this.sexStatus,
    this.ageStatus,
    this.addressStatus,
    this.homeShareStatus,
    this.contentShareStatus,
    this.searchStatus,
  );

  factory PrivacyInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$PrivacyInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PrivacyInfoToJson(this);
}
