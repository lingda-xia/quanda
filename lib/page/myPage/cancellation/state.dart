import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/model/ImgEntity.dart';

/// 注销原因的数据层
class CancellationState {
  /// 选择的原因下标
  late int selectIndex;

  /// 原因列表
  late List<String> reasonList;

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 图片选择器
  late ImagePicker picker;

  /// 图片列表
  late List<ImgEntity> galleryItems;

  /// 初始化 构造函数
  CancellationState() {
    reasonList = [
      "多个账号/想要注册新账号",
      "不想用圈达了",
      "其他",
    ];

    selectIndex = -1;

    textContent = "";

    textController = TextEditingController();

    picker = ImagePicker();

    galleryItems = [];
  }
}
