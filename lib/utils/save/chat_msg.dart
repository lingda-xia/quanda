import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

/// @description :键值对存储
/// 聊天消息存储
class ChatMag {
  /// 键值对存储
  static SharedPreferences sp = Get.find<SharedPreferences>();

  /// 保存id列表
  static saveIDList(String id) async {
    /// 先获取到保存的值
    final List<String>? localMsgIDList = sp.getStringList("localMsgIDList");
    if(localMsgIDList == null) {
      await sp.setStringList("localMsgIDList", [id]);
    } else if(!localMsgIDList.contains(id)) {
      /// 存储的列表中是否已有该id
      await sp.setStringList("localMsgIDList", [...localMsgIDList, id]);
    }
  }

  /// 删除id列表
  static deleteIDList() async {
    await sp.remove("localMsgIDList");
  }

  /// 获取id列表
  static getIDList() async {
    try {
      final  List<String>? list = sp.getStringList("localMsgIDList");
      if (list == null) {
        return null;
      } else {
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 保存消息列表
  /// [msgList] 消息列表
  /// [id] 用户id
  static saveMsgList(List<V2TimMessage>? msgList, String id) async {
    late List<String> storedMsgList;
    if (msgList != null && msgList.isNotEmpty) {
      /// 取最新的数据
      final storedMsg = msgList.getRange(0, min(20, msgList.length - 1));
      storedMsgList =
          storedMsg.map((item) => jsonEncode(item.toJson())).toList();
    } else {
      storedMsgList = [];
    }
    await sp.setStringList("msgList$id", storedMsgList);
  }

  /// 删除消息列表
  static deleteMsgList() async {
    await sp.remove("localMsgIDList");
  }

  /// 获取消息列表
  static getMsgList(String id) async {
    try {
      final  List<String>? list = sp.getStringList("msgList$id");
      if (list == null) {
        return null;
      } else {
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }


}
