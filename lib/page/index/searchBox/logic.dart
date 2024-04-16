import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/index.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/index/IndexSearch.dart';
import 'package:quanda/model/index/UserSearch.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 首页 搜索框 逻辑层
class SearchBoxLogic extends GetxController {
  SearchBoxState state = SearchBoxState();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void init() async {
    /// 获取定位信息
    await getLocation();
  }

  /// 首页搜索列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    IndexRequest.homePageSearchList(
      lat: state.address.latitude.toString(),
      lon: state.address.longitude.toString(),
      keyword: state.textContent,
      type: type,
      page: page,
      success: (data) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        /// 列表数据
        List res = data.records;

        /// 互动列表
        List<IndexSearch> list = [];

        /// 用户列表
        List<UserSearch> userList = [];

        /// 用户数据
        if (type == 0) {
          for (int i = 0; i < res.length; i++) {
            userList.add(UserSearch.fromJson(res[i]));
          }

          if (data.current == 1) {
            state.userList = userList;
          } else {
            state.userList.addAll(userList);
          }
        } else {
          /// 互动数据
          for (int i = 0; i < res.length; i++) {
            list.add(IndexSearch.fromJson(res[i]));
          }

          if (data.current == 1) {
            state.list = list;
          } else {
            state.list.addAll(list);
          }
        }

        /// 将数据返回
        completer.complete(data);
        update();
      },
      fail: (code, msg) {
        /// 重置列表状态关闭
        state.reload[type] = false;

        /// 将错误code输出
        completer.completeError(code);
      },
    );

    return completer.future;
  }

  /// 获取定位信息
  getLocation() async {
    var value = await SpUtil.getAddress();
    if (value == null) return;
    state.address = value;
    update();
  }

  /// 点赞发布
  giveRelease(int id, int type) {
    /// 发起请求
    PublishRequest.giveRelease(
      id: id,
      success: (data) {
        state.reload[type] = true;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 设置tab下标
  void setIndex(int index) {
    state.focusNode.unfocus();

    state.index = index;

    update();
  }

  /// 监听搜索输入
  void onChanged(String msg) {
    state.textContent = msg;

    if (!state.allow) {
      state.allow = true;
    } else {
      state.reload[state.index] = true;
    }
    update();
  }

  /// 查看信息
  /// [value] 是不是好友
  seeInformation(String value, String id) {
    /// 取消焦点
    state.focusNode.unfocus();

    if(value == "1") {
      /// 好友状态信息
      Get.toNamed(RouteConfig.viewFriends, arguments: int.parse(id));
    } else {
      /// 非好友状态信息
      Get.toNamed("${RouteConfig.nonFriends}?id=$id");
    }
  }

  /// 前往查看详情页
  void goToSeeDetails(String id) {
    Get.toNamed("${RouteConfig.seeDetails}?id=$id");
  }

  /// 前往他人主页
  void goToOthers(String id) {
    Get.toNamed("${RouteConfig.others}?id=$id");
  }
}
