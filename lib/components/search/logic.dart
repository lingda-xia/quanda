import 'dart:async';

import 'package:get/get.dart';
import 'package:quanda/api/chat.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/chat/SearchEntity.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 搜索 逻辑层
class SearchLogic extends GetxController {
  final SearchState state = SearchState();

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 获取搜索列表
  Future<LongList> getList(int page) async {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    ChatRequest.friendSearchList(
      name: state.textContent,
      page: page,
      success: (data) {
        /// 重置列表状态关闭
        state.reload = false;

        List res = data.records;

        List<SearchEntity> list = [];
        for (int i = 0; i < res.length; i++) {
          list.add(SearchEntity.fromJson(res[i]));
        }

        if (data.current == 1) {
          state.list = list;
        } else {
          state.list.addAll(list);
        }

        /// 将数据返回
        completer.complete(data);
        update();
      },
      fail: (code, msg) {
        /// 重置列表状态关闭
        state.reload = false;
        /// 将错误code输出
        completer.completeError(code);
      },
    );
    return completer.future;
  }

  /// 搜索用户和好友
  friendSearchList() {
    if(state.allow) {
      state.reload = true;
    } else {
      state.allow = true;
    }
    update();
  }

  /// 查看信息
  /// [value] 是不是好友
  seeInformation(bool value, String id) {
    /// 取消焦点
    state.focusNode.unfocus();
    if(value) {
      /// 好友状态信息
      Get.toNamed(RouteConfig.viewFriends, arguments: int.parse(id));
    } else {
      /// 非好友状态信息
      Get.toNamed("${RouteConfig.nonFriends}?id=$id");
    }
  }

  /// 监听搜索输入
  void onChanged(String msg) {
    state.textContent = msg;
    if(state.allow) {
      state.reload = true;
    } else {
      state.allow = true;
    }
    update();
  }
}
