import 'package:json_annotation/json_annotation.dart';

part 'UserInfo.g.dart';

@JsonSerializable()
class UserInfo extends Object {
  int userId;

  String phone;

  int deleteStatus;

  int useStatus;

  String nickname;

  double balance;

  int sex;

  String birthday;

  String address;

  String avatarUrl;

  int authStatus;

  UserInfo(
    this.userId,
    this.phone,
    this.deleteStatus,
    this.useStatus,
    this.nickname,
    this.balance,
    this.sex,
    this.birthday,
    this.address,
    this.avatarUrl,
    this.authStatus,
  );

  factory UserInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
