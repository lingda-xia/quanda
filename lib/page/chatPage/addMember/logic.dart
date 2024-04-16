import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';

/// 添加成员的逻辑层
class AddMemberLogic extends GetxController {
  AddMemberState state = AddMemberState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    init();
  }

  /// 初始化
  init() {
    /// 发起请求 获取好友列表
    ChatRequest.tagFriendInfoList(
      name: state.textContent,
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

  /// 判断是否包含已选中的好友
  bool contain(FriendList item) {
    bool value = false;

    /// 是否包含
    value = state.selected.contains(item);

    return value;
  }

  /// 完成
  complete() {
    Get.back(result: state.selected);
  }

  /// 更新复选框的值
  void upDateChecked(FriendList item, itemBuilder) {
    /// 是否包含
    int value = state.selected.indexOf(item);

    /// 取消选择好友
    if (value != -1) {
      /// 删除选择列表中该好友
      state.selected.removeAt(value);

      /// 执行删除并执行动画
      state.globalKey.currentState!.removeItem(value, (context, animation) {
        /// todo 删除动画待完成
        // 删除过程执行的是反向动画，animation.value 会从1变为0
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            //让透明度变化的更快一些
            curve: const Interval(0.5, 1.0),
          ),
          child: Container(),
        );
      }, duration: const Duration(milliseconds: 2000));
    } else {
      /// 添加选择的好友加入到选择列表中
      state.selected.add(item);

      /// 加入好友并执行添加动画
      state.globalKey.currentState!.insertItem(state.selected.length - 1,
          duration: const Duration(milliseconds: 1000));

      /// 如果选择列表超过3 之后每添加一个就移动到当前添加的好友
      if (state.selected.length > 3) {
        state.scrollController.animateTo(state.selected.length * 100.dp,
            duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
      }
    }
    update();
  }

  /// 监听搜索输入
  void onSearch(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }
}
