import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'CheckInfo.g.dart';

/// [checkCode] 检验code
/// [goodsTitle] 商品标题
/// [goodsImgUrl] 商品主图
/// [createTime] 创建时间
/// [money] 金额
/// [userInfo] 用户信息
/// [type] 1=任务 2=闲置
/// [releaseId] 发布id
/// [sourceOrderId] 源订单id
@JsonSerializable()
class CheckInfo extends Object {
  String checkCode;
  String goodsTitle;
  String goodsImgUrl;
  String createTime;
  double money;
  InfoEntity userInfo;
  int type;
  int releaseId;
  int sourceOrderId;

  CheckInfo(
    this.checkCode,
    this.goodsTitle,
    this.goodsImgUrl,
    this.createTime,
    this.money,
    this.userInfo,
    this.type,
    this.releaseId,
    this.sourceOrderId,
  );

  factory CheckInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$CheckInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckInfoToJson(this);
}
