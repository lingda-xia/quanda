// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FeedbackInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackInfo _$FeedbackInfoFromJson(Map<String, dynamic> json) => FeedbackInfo(
      json['id'] as int,
      json['userId'] as int,
      json['content'] as String,
      json['replyContent'] as String,
      json['mobile'] as String,
      json['status'] as int,
      json['createTime'] as String,
      (json['imageList'] as List<dynamic>)
          .map((e) => ImgEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      InfoEntity.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackInfoToJson(FeedbackInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'content': instance.content,
      'replyContent': instance.replyContent,
      'mobile': instance.mobile,
      'status': instance.status,
      'createTime': instance.createTime,
      'imageList': instance.imageList,
      'userInfo': instance.userInfo,
    };
