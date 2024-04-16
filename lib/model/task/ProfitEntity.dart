import 'package:json_annotation/json_annotation.dart';

part 'ProfitEntity.g.dart';

/// [id] id
/// [userId] 用户id
/// [type] 1=金币收益 2=现金收益
/// [profitDesc] 收益描述
/// [profitNumber] 金币
/// [createTime] 时间
/// [lon] 经度
/// [lat] 纬度
@JsonSerializable()
class ProfitEntity extends Object {
  int id;

  int userId;

  int type;

  String profitDesc;

  double profitNumber;

  String createTime;

  ProfitEntity(
    this.id,
    this.userId,
    this.type,
    this.profitDesc,
    this.profitNumber,
    this.createTime,
  );

  factory ProfitEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$ProfitEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProfitEntityToJson(this);
}
