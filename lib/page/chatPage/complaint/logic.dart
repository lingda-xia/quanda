import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 投诉的逻辑层
class ComplaintLogic extends GetxController {
  ComplaintState state = ComplaintState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 监听搜索输入
  void onSearch(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }

  /// 清空输入框
  void clearInputBox() {
    state.textContent = "";
    state.textController.text = "";
    update();
  }

  /// 更新标签的选择
  void updateCheck(int index) {
    state.labelList[index].isCheck = !state.labelList[index].isCheck;

    update();
  }

}
