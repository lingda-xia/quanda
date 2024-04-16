import 'package:json_annotation/json_annotation.dart';

part 'TaskParam.g.dart';

@JsonSerializable()
class TaskParam extends Object {
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

  int taskType;

  int sex;

  int personNumber;

  int finishMoney;

  int taskTime;

  int status;

  TaskParam(
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
    this.taskType,
    this.sex,
    this.personNumber,
    this.finishMoney,
    this.taskTime,
    this.status,
  );

  factory TaskParam.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskParamFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskParamToJson(this);
}
