import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/ImgEntity.dart';

part 'ReleaseList.g.dart';

/// [id] id
/// [userId]发布者id
/// [type] //类型 1=动态 2=广播 3=任务 4=闲置
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
/// [commentNumber] 评论数量
/// [broadcastStatus] 是否在推广时间内 0= 否 1=是
/// [deleteStatus] 0=删除 1=未删除
/// [giveStatus] 是否点赞 0
/// [createTime] 创建时间
/// [idleOrderStatus] 闲置订单情况  false = 不可查看订单详情  true 反之
/// [mediaList] 图片列表
/// [currentNumber] 当前参与人数
@JsonSerializable()
class ReleaseList extends Object {
  int id;
  int userId;
  int type;
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
  int commentNumber;
  int broadcastStatus;
  int deleteStatus;
  int giveStatus;
  String createTime;
  bool idleOrderStatus;
  List<ImgEntity> mediaList;
  int currentNumber;

  ReleaseList(
    this.id,
    this.userId,
    this.type,
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
    this.commentNumber,
    this.broadcastStatus,
    this.deleteStatus,
    this.giveStatus,
    this.createTime,
    this.idleOrderStatus,
    this.mediaList,
    this.currentNumber,
  );

  factory ReleaseList.fromJson(Map<String, dynamic> srcJson) =>
      _$ReleaseListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ReleaseListToJson(this);
}
