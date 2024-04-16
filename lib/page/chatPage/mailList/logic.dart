import 'dart:math';

import 'package:get/get.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_friend_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'state.dart';

/// 通讯录逻辑层
class MailListLogic extends GetxController {
  final MailListState state = MailListState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    init();
    /// 腾讯im获取好友列表
    getFriendsList();
  }

  /// 初始化
  init() {
    /// 发起请求 获取好友列表
    ChatRequest.friendList(
      type: 1,
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

  /// 获取好友列表
  getFriendsList() async {
    V2TimValueCallback<List<V2TimFriendInfo>> res =
    await TencentImSDKPlugin.v2TIMManager.v2TIMFriendshipManager.getFriendList();

    print("腾讯im获取好友列表${res.toJson()}");
  }

  /// 前往查看好友状态页面
  void goToViewFriends(FriendList item) async {
    await Get.toNamed(RouteConfig.viewFriends, arguments: item.toUserId);
    /// 重新获取好友列表
    init();
  }

  /// 前往搜索页
  void goToSearchPage() {
    Get.toNamed(RouteConfig.search);
  }

  /// 前往黑名单页面
  void goToBlacklist() async {
    await Get.toNamed(RouteConfig.blacklist);
    /// 重新获取好友列表
    init();
  }

  /// 功能区域前往页面前往页面
  void goToPage(String page) async {
    if (page == "企业商家") {
      CustomToast.showToast("招商中", paleGreenColor);
    } else {
      await Get.toNamed(page);
      /// 重新获取好友列表
      init();
    }
  }
}
