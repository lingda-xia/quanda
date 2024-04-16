import 'package:json_annotation/json_annotation.dart';

part 'DynamicParam.g.dart';

@JsonSerializable()
class DynamicParam extends Object {
  String title;

  String address;

  String lon;

  String lat;

  String content;

  List<String> media;

  List<dynamic> imgList;

  int status;

  DynamicParam(
    this.title,
    this.address,
    this.lon,
    this.lat,
    this.content,
    this.media,
    this.imgList,
    this.status,
  );

  factory DynamicParam.fromJson(Map<String, dynamic> srcJson) =>
      _$DynamicParamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DynamicParamToJson(this);
}
