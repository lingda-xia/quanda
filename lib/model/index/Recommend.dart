import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'Recommend.g.dart';

/// [id] id
/// [userId]发布者id
/// [type] //类型 1=动态 2=广播 3=任务 4=闲置
/// [title] 标题
/// [lon] 经度
/// [lat] 纬度
/// [giveNumber] 点赞
/// [distance] 距离
/// [giveStatus] 是否点赞
/// [mainImgUrl] 媒体
/// [extension] 媒体类型
/// [videoImg] 视频封面
/// [userInfo] 用户信息
@JsonSerializable()
class Recommend extends Object {
  int id;

  int userId;

  int type;

  String title;

  String lon;

  String lat;

  int giveNumber;

  String distance;

  int giveStatus;

  String mainImgUrl;

  String extension;

  String? videoImg;

  InfoEntity userInfo;

  Recommend(
    this.id,
    this.userId,
    this.type,
    this.title,
    this.lon,
    this.lat,
    this.giveNumber,
    this.distance,
    this.giveStatus,
    this.mainImgUrl,
    this.extension,
    this.videoImg,
    this.userInfo,
  );

  factory Recommend.fromJson(Map<String, dynamic> srcJson) =>
      _$RecommendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecommendToJson(this);
}
