import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';

/// 设置标签的逻辑层
class SetLabelLogic extends GetxController {
  SetLabelState state = SetLabelState();

  @override
  void onInit() {
    super.onInit();
    state.id = Get.parameters["id"]!;
    state.textContent = Get.parameters["name"]!;
    state.textController.text = Get.parameters["name"]!;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    init();
  }

  /// 初始化
  init() {
    /// 发起请求 获取标签好友列表
    ChatRequest.tagFriendList(
      tagId: state.id,
      success: (data) async {
        for (int i = 0; i < data.length; i++) {
          /// 提取名字首字的拼音
          String value = PinyinHelper.getFirstWordPinyin(data[i].remarkName);
          String str = value.substring(0, 1);

          /// 正则表达式  是否是字母
          RegExp regExp = RegExp(r"^[a-zA-Z]+$");
          bool whether = regExp.hasMatch(str);

          if (whether) {
            data[i].indexLetter = str.toUpperCase();
          } else {
            data[i].indexLetter = "#";
          }
        }

        /// 排序成员列表
        List<FriendList> list = array(data);

        state.friendList = list;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 编辑标签
  editLabel() {
    /// 发起请求
    ChatRequest.tagSave(
      name: state.textContent,
      id: state.id,
      success: (data) {
        /// 如果需要添加的成员数组不为空
        if(state.selected.isNotEmpty) {
          /// 添加好友到标签(支持批量)
          tagFriendAdd();
        } else {
          Get.back(result: "success");
        }
      },
      fail: (code, msg) {},
    );
  }

  /// 添加好友到标签(支持批量)
  tagFriendAdd() {
    /// 去重
    List<String> ids = state.selected.toSet().toList();

    /// 发起请求
    ChatRequest.tagFriendAdd(
      ids: ids,
      tagId: state.id,
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
        /// 提取id
        for(int i = 0; i < data.length; i++) {
          state.selected.add(data[i].toUserId.toString());
        }
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
