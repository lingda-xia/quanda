import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/personal/ReceivingEntity.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'IdleDetail.g.dart';

/// [orderId] 订单id
/// [idleId] 发布id
/// [orderNo] 订单号
/// [userId] 用户id
/// [sellUserId] 发布人id
/// [goodsTitle] 商品标题
/// [checkStatus] 地址信息
/// [orderStatus] 订单状态 0=未支付 1=已支付(待发货) 2=已发货(待收货) 3=已收货(已完成) 4=申请退款 5=同意退款(已退款) 6=订单取消(结束)
/// [logisticsType] 物流方式 0=自提 1=快递
/// [totalMoney] 订单金额
/// [expressName] 快递公司名称
/// [expressId] 快递公司id
/// [expressNo] 快递单号
/// [checkCode] 检验code
/// [deleteStatus] 删除订单 0=是 1=否
/// [deliveryId] 收货地址id
/// [createTime] 下单时间
/// [userInfo] 用户信息
/// [userDeliveryInfo] 收货信息
/// [mediaUrl] 商品主图
@JsonSerializable()
class IdleDetail extends Object {
  int orderId;
  int idleId;
  String orderNo;
  int userId;
  int sellUserId;
  String goodsTitle;
  int checkStatus;
  int orderStatus;
  int logisticsType;
  double totalMoney;
  String expressName;
  int expressId;
  String expressNo;
  String checkCode;
  int deleteStatus;
  int deliveryId;
  String createTime;
  InfoEntity userInfo;
  ReceivingEntity? userDeliveryInfo;
  String mediaUrl;

  IdleDetail(
    this.orderId,
    this.idleId,
    this.orderNo,
    this.userId,
    this.sellUserId,
    this.goodsTitle,
    this.checkStatus,
    this.orderStatus,
    this.logisticsType,
    this.totalMoney,
    this.expressName,
    this.expressId,
    this.expressNo,
    this.checkCode,
    this.deleteStatus,
    this.deliveryId,
    this.createTime,
    this.userInfo,
    this.userDeliveryInfo,
    this.mediaUrl,
  );

  factory IdleDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$IdleDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IdleDetailToJson(this);
}
