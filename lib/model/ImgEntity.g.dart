// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImgEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImgEntity _$ImgEntityFromJson(Map<String, dynamic> json) => ImgEntity(
      json['id'] as int,
      json['filePath'] as String,
      json['extension'] as String?,
    )..fileVideoPath = json['fileVideoPath'] as String?;

Map<String, dynamic> _$ImgEntityToJson(ImgEntity instance) => <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'extension': instance.extension,
      'fileVideoPath': instance.fileVideoPath,
    };
