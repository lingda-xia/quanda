import 'package:json_annotation/json_annotation.dart';

part 'OrderInfo.g.dart';
/// [payFlag] true代表不需要支付
/// [orderId] 订单id
/// [module] release = 广播任务支付   orderPay = 订单支付
@JsonSerializable()
class OrderInfo extends Object {
  bool payFlag;

  int orderId;

  String module;

  OrderInfo(
      this.payFlag,
      this.orderId,
      this.module,
  );

  factory OrderInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OrderInfoToJson(this);
}
