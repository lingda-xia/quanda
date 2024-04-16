import 'package:json_annotation/json_annotation.dart';

part 'BillEntity.g.dart';

/// [id] id
/// [userId] 用户id
/// [type] 类型  0=支出 1=收入
/// [money] 金额
/// [accountDesc] 备注说明
/// [createTime] 创建时间
@JsonSerializable()
class BillEntity extends Object {
  int id;
  int userId;
  int type;
  double money;
  String accountDesc;
  String createTime;

  BillEntity(
    this.id,
    this.userId,
    this.type,
    this.money,
    this.accountDesc,
    this.createTime,
  );

  factory BillEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$BillEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BillEntityToJson(this);
}
