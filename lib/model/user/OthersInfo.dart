import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/chat/CheckMessage.dart';

part 'OthersInfo.g.dart';

/// [userId] 用户id
/// [nickname] 用户名称
/// [authStatus] 是否实名认证 0=未实名 1=已实名
/// [avatarUrl] 头像
/// [sex] 性别
/// [address] 地区
/// [introduction] 简介
/// [tagName] 标签名称
/// [remarkName] 备注名称
/// [toDesc] 好友描述
/// [source] 来源
/// [friendStatus] 是否好友  0=否 1=是
/// [momentList] 个人主页 瞬间动态图片
/// [checkMessageList] 验证信息列表

@JsonSerializable()
class OthersInfo extends Object {
  String userId;

  String nickname;

  int authStatus;

  String avatarUrl;

  int sex;

  String address;

  String introduction;

  String tagName;

  String remarkName;

  String toDesc;

  String source;

  int friendStatus;

  List<String> momentList;

  List<CheckMessage> checkMessageList;

  OthersInfo(
    this.userId,
    this.nickname,
    this.authStatus,
    this.avatarUrl,
    this.sex,
    this.address,
    this.introduction,
    this.tagName,
    this.remarkName,
    this.toDesc,
    this.source,
    this.friendStatus,
    this.momentList,
    this.checkMessageList,
  );

  factory OthersInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$OthersInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OthersInfoToJson(this);
}
