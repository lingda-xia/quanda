import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'OrderEntity.g.dart';

/// [id] id
/// [sourceOrderId] 订单来源id
/// [userId] 买方id
/// [sellUserId] 卖方id
/// [orderNo] 订单号
/// [goodsTitle] 名称
/// [orderType] 订单类型 1=任务订单 2=闲置订单
/// [orderStatus] 订单状态 0=未支付 1=已支付(待发货) 2=已发货(待收货) 3=已收货(已完成) 4=申请退款 5=同意退款(已退款) 6=订单取消(结束)
/// [orderMedia] 媒体
/// [deleteStatus] 删除订单 0=已删除  1=未删除
/// [checkStatus] 是否检验 0=否 1=是
/// [totalMoney] 总金额
/// [refundStatus] 申请退款 0未申请   1申请
/// [createTime] 创建时间
/// [mediaList] 媒体列表
/// [userInfo] 卖方信息
@JsonSerializable()
class OrderEntity extends Object {
  int id;
  int sourceOrderId;
  int userId;
  int sellUserId;
  String orderNo;
  String goodsTitle;
  int orderType;
  int orderStatus;
  String orderMedia;
  int deleteStatus;
  int checkStatus;
  double totalMoney;
  int refundStatus;
  String createTime;
  List<ImgEntity> mediaList;
  InfoEntity userInfo;

  OrderEntity(
    this.id,
    this.sourceOrderId,
    this.userId,
    this.sellUserId,
    this.orderNo,
    this.goodsTitle,
    this.orderType,
    this.orderStatus,
    this.orderMedia,
    this.deleteStatus,
    this.checkStatus,
    this.totalMoney,
    this.refundStatus,
    this.createTime,
    this.mediaList,
    this.userInfo,
  );

  factory OrderEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderEntityToJson(this);
}
