import 'package:json_annotation/json_annotation.dart';

part 'ImgEntity.g.dart';

/// flutter pub run build_runner watch
@JsonSerializable()
class ImgEntity extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'filePath')
  String filePath;

  String? extension;

  String? fileVideoPath;

  ImgEntity(this.id,this.filePath,this.extension);

  factory ImgEntity.fromJson(Map<String, dynamic> srcJson) => _$ImgEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImgEntityToJson(this);

}


