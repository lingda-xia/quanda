import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';

/// [address] 详细信息
/// [street]大街
/// [country] 国家
/// [province] 省份
/// [city] 城市
/// [district] 区县
/// [latitude] 经度
/// [longitude] 纬度
/// [adCode] 地区码
@JsonSerializable()
class Address extends Object {
  String address;

  String street;

  String country;

  String province;

  String city;

  String district;

  double latitude;

  double longitude;

  String adCode;

  Address(
    this.address,
    this.street,
    this.country,
    this.province,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.adCode,
  );

  factory Address.fromJson(Map<String, dynamic> srcJson) =>
      _$AddressFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
