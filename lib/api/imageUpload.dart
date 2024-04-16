import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/http/http_request.dart';
import 'package:quanda/http/request.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'dart:convert';

///  图片上传 接口
class ImageUpload {
  /// 图片上传
  /// [imgList]选择的图片列表
  /// [success] 请求成功回调
  /// [fail] 请求失败回调
  /// [loading] 是否打开loading
  /// [toast] 是否打开信息提示
  static upload(
    List<XFile>? imgList, {
    Success<List<ImgEntity>>? success,
    Fail? fail,
    bool loading = true,
    bool toast = true,
  }) async {
    /// 创建FormData实例
    var formData = FormData.fromMap({});

    /// 将图片列表中的图片地址添加到FormData中
    for (int i = 0; i < imgList!.length; i++) {
      formData.files.add(
        MapEntry(
          "file",
          await MultipartFile.fromFile(
            imgList[i].path,
          ),
        ),
      );
    }

    /// 发起请求
    Request.post<dynamic>("/api/uploadFile", formData,
        loading: loading, toast: false, success: (data) {
      print("接口仓库的请求返回的图片列表$data");

      /// 最终的图片列表
      List<ImgEntity> list = [];

      for (int i = 0; i < data.length; i++) {
        list.add(ImgEntity.fromJson(data[i]));
      }
      print("这是转换后的图片列表$list");

      if (success != null) {
        /// 请求成功回调
        success(list);
      }
    }, fail: (code, msg) {
      if (fail != null) {
        /// 请求失败回调
        fail(code, msg);
      }
    });
  }
}
