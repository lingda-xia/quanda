import 'package:json_annotation/json_annotation.dart';

part 'SearchResult.g.dart';

@JsonSerializable()
class SearchResult extends Object {
  /// 地址
  String address;

  /// 距离 m
  String distance;

  /// 城市名字
  String city;

  /// 区
  String district;

  /// 店名
  String name;

  /// 经纬度
  String location;

  SearchResult(
      {required this.address,
        required this.distance,
        required this.city,
        required this.district,
        required this.name,
        required this.location});

  factory SearchResult.fromJson(Map<String, dynamic> srcJson) =>
      _$SearchResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
