import 'package:json_annotation/json_annotation.dart';

part 'DailyTask.g.dart';

/// [type] 类别
/// [number] 已完成数
/// [count] 总数
/// [gold] 奖励金额
@JsonSerializable()
class DailyTask extends Object {
  String type;

  int number;

  int count;

  double gold;

  DailyTask(
      this.type,
      this.number,
      this.count,
      this.gold,
  );

  factory DailyTask.fromJson(Map<String, dynamic> srcJson) =>
      _$DailyTaskFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DailyTaskToJson(this);
}
