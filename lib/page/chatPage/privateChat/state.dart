import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 私聊 的数据层
class PrivateChatState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 控制输入框的焦点
  late FocusNode focusNode;

  /// 刷新控制器
  late EasyRefreshController controller;

  /// 列表控制器
  late ScrollController listController;

  /// 图片选择器
  late ImagePicker picker;

  /// 用户id
  late String id;

  /// 用户名称
  late String name;

  /// 星期列表
  late List<String> weekdayList;

  /// 初始化 构造函数
  PrivateChatState() {
    id = "";
    name = "";
    textContent = "";
    textController = TextEditingController();
    focusNode = FocusNode();
    picker = ImagePicker();
    controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    listController = ScrollController();
    weekdayList = ["", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期天"];
  }

}