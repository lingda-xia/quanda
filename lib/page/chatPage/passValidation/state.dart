import 'package:flutter/material.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 通过验证的数据层
class PassValidationState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 用户id
  late String id;

  /// 标签
  late String label;

  /// 标签id
  late String tagId;

  /// 初始化 构造函数
  PassValidationState() {
    textContent = "";
    textController = TextEditingController();
    id = "0";
    label = "添加标签";
    tagId = "";
  }

}


