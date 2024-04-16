import 'package:json_annotation/json_annotation.dart';

part 'RadioParam.g.dart';

@JsonSerializable()
class RadioParam extends Object {
  String title;

  String address;

  String lon;

  String lat;

  String content;

  List<String> media;

  List<dynamic> imgList;

  double payMoney;

  double rangeKm;

  double broadcastTime;

  int status;

  RadioParam(
    this.title,
    this.address,
    this.lon,
    this.lat,
    this.content,
    this.media,
    this.imgList,
    this.payMoney,
    this.rangeKm,
    this.broadcastTime,
    this.status,
  );

  factory RadioParam.fromJson(Map<String, dynamic> srcJson) =>
      _$RadioParamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RadioParamToJson(this);
}
