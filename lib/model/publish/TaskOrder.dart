import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'TaskOrder.g.dart';

/// [orderId] 订单id
/// [taskId] 发布任务id
/// [orderNo] 订单号
/// [userId] 用户id
/// [sellUserId] 发布人id
/// [goodsTitle] 商品标题
/// [checkStatus] 是否检验 0=未 1=是
/// [orderStatus] 订单状态 0=未支付 1=已支付(待发货) 2=已发货(待收货) 3=已收货(已完成) 4=申请退款 5=同意退款(已退款) 6=订单取消(结束)
/// [totalMoney] 订单金额
/// [taskTime] 任务时长
/// [mediaUrl] 商品主图
/// [checkTime] 核验时间
/// [createTime] 创建时间
/// [userInfo] 卖方信息
@JsonSerializable()
class TaskOrder extends Object {
  int orderId;
  int taskId;
  String orderNo;
  int userId;
  int sellUserId;
  String goodsTitle;
  int checkStatus;
  int orderStatus;
  double totalMoney;
  int taskTime;
  String mediaUrl;
  String? checkTime;
  String createTime;
  InfoEntity userInfo;

  TaskOrder(
    this.orderId,
    this.taskId,
    this.orderNo,
    this.userId,
    this.sellUserId,
    this.goodsTitle,
    this.checkStatus,
    this.orderStatus,
    this.totalMoney,
    this.taskTime,
    this.mediaUrl,
    this.checkTime,
    this.createTime,
    this.userInfo,
  );

  factory TaskOrder.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskOrderFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskOrderToJson(this);
}
