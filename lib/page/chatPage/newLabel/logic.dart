import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';

/// 新建标签的逻辑层
class NewLabelLogic extends GetxController {
  NewLabelState state = NewLabelState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 添加标签
  addLabel() {
    /// 发起请求
    ChatRequest.tagSave(
      name: state.textContent,
      success: (data) {
        /// 如果需要添加的成员数组不为空
        if(state.friendList.isNotEmpty) {
          /// 添加好友到标签(支持批量)
          tagFriendAdd(data);
        } else {
          Get.back(result: "success");
        }
      },
      fail: (code, msg) {},
    );
  }

  /// 添加好友到标签(支持批量)
  tagFriendAdd(String id) {

    List<String> ids = [];

    for(int i = 0; i < state.friendList.length; i++) {
      ids.add(state.friendList[i].toUserId.toString());
    }

    /// 发起请求
    ChatRequest.tagFriendAdd(
      ids: ids,
      tagId: id,
      success: (data) {
        Get.back(result: "success");
      },
      fail: (code, msg) {},
    );
  }

  /// 排列
  List<FriendList> array(List<FriendList> data) {
    /// 重置
    state.groupOffsetMap = {};

    /// 排序好友列表
    data.sort((FriendList a, FriendList b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    /// 组之间的距离 初始值是头部widget的高度
    var groupOffset = 247.dp;
    for (int i = 0; i < data.length; i++) {
      if (i == 0) {
        state.groupOffsetMap.addAll({data[i].indexLetter: groupOffset});
        groupOffset += state.groupHeight + state.cellHeight;
      } else if (data[i].indexLetter == data[i - 1].indexLetter) {
        /// 如果当前好友的组名和上一个好友的组名相同  则继续增加距离

        groupOffset += state.cellHeight;
      } else {
        state.groupOffsetMap.addAll({data[i].indexLetter: groupOffset});
        groupOffset += state.groupHeight + state.cellHeight;
      }
    }

    return data;
  }

  /// 去重和重新排列
  again() {
    /// 去重
    final jsonList = state.friendList.map((e) => jsonEncode(e)).toList();
    final uniqueJsonList = jsonList.toSet().toList();
    List<FriendList> result = uniqueJsonList
        .map((item) => FriendList.fromJson(jsonDecode(item)))
        .toList();

    /// 重新排列
    List<FriendList> list = array(result);

    state.friendList = list;

    update();
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

  /// 前往添加成员页面
  void goToAddMember() async {
    var data = await Get.toNamed(RouteConfig.addMember);
    if (data != null) {
      if (data.isNotEmpty) {
        state.friendList.addAll(data);
        again();
      }
    }
  }

  /// 前往查看好友状态页面
  void goToViewFriends(FriendList item) {
    Get.toNamed(RouteConfig.viewFriends, arguments: item.toUserId);
  }
}
