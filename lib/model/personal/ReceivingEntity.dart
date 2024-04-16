import 'package:json_annotation/json_annotation.dart';

part 'ReceivingEntity.g.dart';

/// [id] id
/// [userId] 用户id
/// [address] 详细地址
/// [contact] 联系人
/// [phone] 手机号
/// [areaAddress] 省市区地址
/// [defaultStatus] 是否默认 0=否 1=是
@JsonSerializable()
class ReceivingEntity extends Object {
  int id;
  int userId;
  String address;
  String contact;
  String phone;
  String areaAddress;
  int defaultStatus;

  ReceivingEntity(
    this.id,
    this.userId,
    this.address,
    this.contact,
    this.phone,
    this.areaAddress,
    this.defaultStatus,
  );

  factory ReceivingEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$ReceivingEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReceivingEntityToJson(this);
}
