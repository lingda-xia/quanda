import 'package:json_annotation/json_annotation.dart';

part 'SetAsideParam.g.dart';

@JsonSerializable()
class SetAsideParam extends Object {
  String title;

  String address;

  String lon;

  String lat;

  String content;

  List<String> media;

  List<dynamic> imgList;

  String payMoney;

  int extractType;

  int status;

  SetAsideParam(this.title, this.address, this.lon, this.lat, this.content,
      this.media, this.imgList, this.payMoney, this.extractType, this.status);

  factory SetAsideParam.fromJson(Map<String, dynamic> srcJson) =>
      _$SetAsideParamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SetAsideParamToJson(this);
}
