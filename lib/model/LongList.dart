import 'package:json_annotation/json_annotation.dart';

part 'LongList.g.dart';

/// [records] 列表数据
/// [total] 总条数
/// [size] 每页大小
/// [current] 当前页
/// [time] 时间
/// [data] 特殊数据
/// [pages] 总页数
@JsonSerializable()
class LongList extends Object {
  List records;

  int total;

  int size;

  int current;

  String time;

  Map data;

  int pages;

   LongList(
    this.records,
    this.total,
    this.size,
    this.current,
    this.time,
    this.data,
    this.pages,
  );

  factory LongList.fromJson(Map<String, dynamic> srcJson) =>
      _$LongListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LongListToJson(this);
}
