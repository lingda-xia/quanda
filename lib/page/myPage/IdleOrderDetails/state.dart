import 'package:flutter/material.dart';
import 'package:quanda/model/personal/ExpressEntity.dart';
import 'package:quanda/model/publish/IdleDetail.dart';
import 'package:quanda/model/user/InfoEntity.dart';

/// 闲置订单详情的数据层
class IdleOrderDetailsState {
  /// 输入框控制器
  late TextEditingController textController;

  /// 输入框的文本内容
  late String textContent;

  /// 闲置订单详情
  late IdleDetail data;

  /// 单选按钮匹配的值
  late int groupValue;

  /// 是否弹出底部弹出框
  late bool isShow;

  /// 订单状态
  late List<String> status;

  /// 快递信息
  late ExpressEntity express;

  /// 发布id
  late String id;

  /// 初始化 构造函数
  IdleOrderDetailsState() {
    id = "";
    textContent = "";
    textController = TextEditingController();
    groupValue = 1;
    isShow = false;
    status = ["未支付", "待发货", "已收货", "已完成", "申请退款", "已退款", "已结束"];
    express = ExpressEntity(0, "请选择快递方式", "");
    data = IdleDetail(
      0,
      0,
      "",
      0,
      0,
      "",
      0,
      0,
      0,
      0,
      "",
      0,
      "",
      "",
      0,
      0,
      "",
      InfoEntity("", "", "", ""),
      null,
      "",
    );
  }
}
