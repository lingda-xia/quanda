import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'IndexSearch.g.dart';

/// [extension] 图片后缀
/// [giveStatus] 是否点赞 0 未点  1=已点
/// [distance] 距离
/// [mainImgUrl] 图片地址
/// [videoImg] 视频封面图
/// [id] 发布id
/// [title] 标题
/// [type] 类型 1=动态 2=广播 3=任务 4=闲置
/// [giveNumber] 点赞数
/// [userInfo] 用户信息
@JsonSerializable()
class IndexSearch extends Object {
  String? extension;

  String giveStatus;

  String distance;

  String mainImgUrl;

  String? videoImg;

  String id;

  String title;

  String type;

  String giveNumber;

  String userInfo;

  IndexSearch(
    this.extension,
    this.giveStatus,
    this.distance,
    this.mainImgUrl,
    this.videoImg,
    this.id,
    this.title,
    this.type,
    this.giveNumber,
    this.userInfo,
  );

  factory IndexSearch.fromJson(Map<String, dynamic> srcJson) =>
      _$IndexSearchFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IndexSearchToJson(this);
}
