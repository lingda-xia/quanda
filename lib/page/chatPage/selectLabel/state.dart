import 'package:flutter/material.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/utils/ui/screen.dart';

/// 选择标签的数据层
class SelectLabelState {

  /// 选择的标签
  late LabelEntity select;

  /// 标签列表
  late List<LabelEntity> list;

  /// 用户id
  late String id;

  /// 初始化 构造函数
  SelectLabelState() {
    select = LabelEntity(0, 0, "", "", 0);

    list = [];

    id = "";
  }

}


