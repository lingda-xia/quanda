import 'package:json_annotation/json_annotation.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/user/InfoEntity.dart';

part 'FeedbackInfo.g.dart';

/// [id] id
/// [userId] 用户id
/// [content] 反馈内容
/// [replyContent] 回复内容
/// [mobile] 手机号码
/// [status] 1=处理中 2=处理完成
/// [createTime] 创建时间
/// [imageList] 图片列表
/// [userInfo] 用户信息
@JsonSerializable()
class FeedbackInfo extends Object {
  int id;
  int userId;
  String content;
  String replyContent;
  String mobile;
  int status;
  String createTime;
  List<ImgEntity> imageList;
  InfoEntity userInfo;

  FeedbackInfo(
    this.id,
    this.userId,
    this.content,
    this.replyContent,
    this.mobile,
    this.status,
    this.createTime,
    this.imageList,
    this.userInfo,
  );

  factory FeedbackInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$FeedbackInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackInfoToJson(this);
}
