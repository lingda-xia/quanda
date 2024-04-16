import 'package:json_annotation/json_annotation.dart';

import 'ReceivingEntity.dart';

part 'ConfirmInfo.g.dart';

/// [id] id
/// [imageStr] 图片
/// [title] 标题
/// [payMoney] 金额
/// [extractType] 提取方式 1=上门自提 2=我出邮费 3=你出邮费
/// [addressInfo] 地址信息对象
@JsonSerializable()
class ConfirmInfo extends Object {
  int id;
  String imageStr;
  String title;
  double payMoney;
  int extractType;
  ReceivingEntity? addressInfo;

  ConfirmInfo(
    this.id,
    this.imageStr,
    this.title,
    this.payMoney,
    this.extractType,
    this.addressInfo,
  );

  factory ConfirmInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$ConfirmInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ConfirmInfoToJson(this);
}
