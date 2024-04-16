import 'package:json_annotation/json_annotation.dart';

import 'SignData.dart';

part 'TaskInfo.g.dart';

/// [userId] 用户id
/// [balance] 余额
/// [gold] 金币余额
/// [firstCashMoney] 体验提现金额  0 = 已提现过隐藏模块
/// [firstSignData] 5天签到列表数据
@JsonSerializable()
class TaskInfo extends Object {
  int userId;

  double balance;

  int gold;

  double firstCashMoney;

  List<SignData?> firstSignData;

  TaskInfo(
    this.userId,
    this.balance,
    this.gold,
    this.firstCashMoney,
    this.firstSignData,
  );

  factory TaskInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$TaskInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TaskInfoToJson(this);
}
