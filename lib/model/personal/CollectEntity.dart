import 'package:json_annotation/json_annotation.dart';

part 'CollectEntity.g.dart';

/// [id] id
/// [releaseId] 发布id
/// [type] 类型 0 =全部 1=动态 2=广播 3=任务 4=闲置
/// [title] 标题
/// [nickname] 呢称
/// [avatarUrl] 头像
/// [media] 图片
/// [fileType] 文件类型
/// [extension] 文件后缀
/// [videoImg] 视频封面图
/// [createTime] 创建时间
@JsonSerializable()
class CollectEntity extends Object {
  int id;
  int releaseId;
  int type;
  String title;
  String nickname;
  String avatarUrl;
  String media;
  String fileType;
  String extension;
  String? videoImg;
  String createTime;

  CollectEntity(
    this.id,
    this.releaseId,
    this.type,
    this.title,
    this.nickname,
    this.avatarUrl,
    this.media,
    this.fileType,
    this.extension,
    this.videoImg,
    this.createTime,
  );

  factory CollectEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$CollectEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CollectEntityToJson(this);
}
