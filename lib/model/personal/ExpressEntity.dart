import 'package:json_annotation/json_annotation.dart';

part 'ExpressEntity.g.dart';

/// [id] id
/// [expressName] 快递公司名称
/// [expressCode] 快递公司编号
@JsonSerializable()
class ExpressEntity extends Object {
  int id;
  String expressName;
  String expressCode;

  ExpressEntity(
    this.id,
    this.expressName,
    this.expressCode,
  );

  factory ExpressEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$ExpressEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExpressEntityToJson(this);
}
