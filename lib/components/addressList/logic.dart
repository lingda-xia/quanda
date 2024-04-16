import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'state.dart';

/// 通讯录列表的逻辑层
class AddressListLogic extends GetxController {
  AddressListState state = AddressListState();

  /// 垂直向下拖拽时
  void updateData(int index) {
    state.indicatorY = 2.28 / state.INDEX_WORDS.length * index - 1.10;//改变坐标 Y值
    state.indicatorText = state.INDEX_WORDS[index];//获取对应的字母
    state.indicatorHidden = false;//是否隐藏指示器
    state.textColor = Colors.white;  // 当前选中索引的文本颜色
    state.backColor = const Color.fromRGBO(104, 210, 188, 1); // 当前选中索引的背景颜色
    update();
  }

  /// 垂直向下拖拽结束
  void endUpdate() {
    state.textColor = const Color.fromRGBO(115, 117, 124, 1);
    state.backColor = Colors.transparent;
    state.indicatorHidden = true;//是否隐藏指示器
    update();
  }

}