import 'package:flutter/material.dart';

/// 投诉的数据层
class ComplaintState {

  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 投诉标签列表
  late List<Label> labelList;

  /// 初始化 构造函数
  ComplaintState() {
    textContent = "";
    textController = TextEditingController();
    labelList = [
      Label(
        title: "发布不当言论",
          isCheck: false,
      ),
      Label(
        title: "发布仿冒物品",
        isCheck: false,
      ),
      Label(
        title: "存在侵权行为",
        isCheck: false,
      ),
      Label(
        title: "账号被盗用",
        isCheck: false,
      ),
      Label(
        title: "欺诈骗钱行为",
        isCheck: false,
      ),
      Label(
        title: "冒充他人",
        isCheck: false,
      ),
    ];
  }

}

/// 标签model
class Label {
  /// 标签标题
  late String title;
  /// 是否选中标签
  late bool isCheck;

  Label({required this.title, required this.isCheck});
}
