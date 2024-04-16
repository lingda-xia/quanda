import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/ImgEntity.dart';

/// 反馈的数据层
class FeedbackState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 手机号码
  late String phone;

  /// 图片选择器
  late ImagePicker picker;

  /// 图片列表
  late List<ImgEntity> galleryItems;

  /// 图片id列表
  late List<int> idList;

  /// 初始化 构造函数
  FeedbackState() {

    textContent = "";

    phone = "";

    textController = TextEditingController();

    picker = ImagePicker();

    galleryItems = [];

    idList = [];
  }
}
