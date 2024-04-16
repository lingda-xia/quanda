import 'package:json_annotation/json_annotation.dart';

part 'RecommendTask.g.dart';

/// [id] id
/// [type] 类别
/// [title] 标题
/// [content] 正文内容
/// [gold] 奖励金额
/// [distance] 距离公里数
/// [lon] 经度
/// [lat] 纬度
@JsonSerializable()
class RecommendTask extends Object {

  int id;

  int type;

  String title;

  String content;

  double gold;

  String distance;

  String lon;

  String lat;

  RecommendTask(
    this.id,
    this.type,
    this.title,
    this.content,
    this.gold,
    this.distance,
    this.lon,
    this.lat,
  );

  factory RecommendTask.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendTaskFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendTaskToJson(this);
}
