import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'DetailsEntity.g.dart';

/// [id] id
/// [userId]发布者id
/// [type] //类型 1=动态 2=广播 3=任务 4=闲置
/// [media] 媒体   用不上
/// [title] 标题
/// [content] 内容
/// [address] 地址信息
/// [lon] 经度
/// [lat] 纬度
/// [rangeKm] 范围内可看(单位k) 公里纬度
/// [broadcastTime] 广播时长(单位分钟) (推广时长)
/// [taskType] 任务类型 1=到店奖励 2= 一起玩耍
/// [sex] 性别要求 0=不限 1=男 2=女
/// [personNumber] 所需人数
/// [finishMoney] 任务完成后每人可获取奖励
/// [taskTime] 任务需要停留时间(单位分钟)
/// [extractType] 提取方式 1=上门自提 2=我出邮费 3=你出邮费
/// [advertMoney] 广告消耗总金额
/// [payMoney] 需要支付总费用
/// [status] 状态 0=审核中 1=审核通过 2=审核不通过 3=未发布 4=结束
/// [reason] 审核不通过原因
/// [giveNumber] 点赞数量
/// [collectNumber] 收藏数量
/// [commentNumber] 评论数量
/// [broadcastStatus] 是否在推广时间内 0= 否 1=是
/// [deleteStatus] 0=删除 1=未删除
/// [createTime] 创建时间
/// [mediaList] 图片列表
// data.mediaList.id	 图片id
// data.mediaList.userId	 用户的id
// data.mediaList.filePath  完整的访问路径
/// [userInfo] 用户信息
/// [buyStatus] 是否可参数或可下单闲置
/// [repayShortNumber] 任务还差多少人
/// [giveStatus] 点赞状态 0=未 1=已点
/// [collectStatus] 收藏状态 0=未 1=已收
@JsonSerializable()
class DetailsEntity extends Object {
  int id;
  int userId;
  int type;
  String media;
  String title;
  String content;
  String address;
  String lon;
  String lat;
  int rangeKm;
  int broadcastTime;
  int taskType;
  int sex;
  int personNumber;
  double finishMoney;
  int taskTime;
  int extractType;
  double advertMoney;
  double payMoney;
  int status;
  String reason;
  int giveNumber;
  int collectNumber;
  int commentNumber;
  int broadcastStatus;
  int deleteStatus;
  String createTime;
  List<ImgEntity> mediaList;
  InfoEntity userInfo;
  bool buyStatus;
  int? repayShortNumber;
  int giveStatus;
  int collectStatus;

  DetailsEntity(
    this.id,
    this.userId,
    this.type,
    this.media,
    this.title,
    this.content,
    this.address,
    this.lon,
    this.lat,
    this.rangeKm,
    this.broadcastTime,
    this.taskType,
    this.sex,
    this.personNumber,
    this.finishMoney,
    this.taskTime,
    this.extractType,
    this.advertMoney,
    this.payMoney,
    this.status,
    this.reason,
    this.giveNumber,
    this.collectNumber,
    this.commentNumber,
    this.broadcastStatus,
    this.deleteStatus,
    this.createTime,
    this.mediaList,
    this.userInfo,
    this.buyStatus,
    this.repayShortNumber,
    this.giveStatus,
    this.collectStatus,
  );

  factory DetailsEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$DetailsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DetailsEntityToJson(this);
}
