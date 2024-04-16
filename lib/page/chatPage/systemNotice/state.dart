import 'package:flutter/material.dart';
import 'package:quanda/model/chat/MsgInfo.dart';
import 'package:quanda/model/chat/SystemMsg.dart';

class NoticeState {

  /// 消息列表
  late List<SystemMsg> list;

  /// 限制的条数
  late int num;

  /// 列表是否需要重新加载
  late bool reload;

  NoticeState() {
    reload = false;
    list = [];
    num = 2;
  }
}