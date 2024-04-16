import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'package:video_player/video_player.dart';
import 'state.dart';

/// 查看信息 的逻辑层
class SeeDetailsLogic extends GetxController {
  SeeDetailsState state = SeeDetailsState();

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取详情信息
    // getDetailsInfo();
  }

  @override
  void onClose() {
    super.onClose();
    state.controller.dispose();
  }

  /// 初始化
  init() {
    UserInfo? value = SpUtil.getUserInfo();
    if (value != null) {
      state.userInfo = value;
      update();
    }
  }

  /// 获取详情信息
  getDetailsInfo() {
    /// 发起请求
    PublishRequest.seeDetails(
      id: int.parse(state.id),
      success: (data) {
        state.details = data;

        /// 媒体的类型 先转为小写状态
        var value = data.mediaList[0].extension?.toLowerCase();

        /// 如果类型为mp4 和 avi  则是视频状态
        if (value == "mp4") {
          state.notVideo = false;
        }
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 点赞发布
  giveRelease() {
    /// 发起请求
    PublishRequest.giveRelease(
      id: state.details.id,
      success: (data) {
        state.details.giveStatus = 1;
        state.details.giveNumber = state.details.giveNumber + 1;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 收藏发布
  collectRelease() {
    PublishRequest.collectRelease(
      id: state.details.id,
      success: (data) {
        state.details.collectStatus = 1;
        state.details.collectNumber = state.details.collectNumber + 1;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 创建订单
  orderSave() {
    /// 发起请求
    UserRequest.orderSave(
      type: state.details.type,
      id: state.details.id,
      toast: true,
      success: (data) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back();
        });
      },
      fail: (code, msg) {},
    );
  }

  /// 打开提示窗  是否接受此任务
  openTips() {
    Get.dialog(
      CustomDialog(
        /// 确认事件
        confirm: () {
          /// 创建订单
          orderSave();
        },

        /// 内容
        content: "是否接受此任务？",

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "确认",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 展开全部
  open() {
    state.develop = !state.develop;
    update();
  }

  /// 监听输入
  void onInput(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }

  /// 前往他人主页
  void goToOthers(String id) {
    if (!state.close) {
      Get.toNamed("${RouteConfig.others}?id=$id");
    } else {
      Get.back();
    }
  }

  /// 前往视频预览
  void goToVideoPreview() {
    Get.toNamed(RouteConfig.videoPreview,
        arguments: state.details.mediaList[0].filePath);
  }

  /// 前往确认订单
  void goToConfirmOrder() async {
    var data = await Get.toNamed(RouteConfig.confirmOrder, arguments: state.details.id);

    if(data == "success") {
      /// 获取详情信息
      getDetailsInfo();
    }
  }

  /// 前往私聊页面
  void goToPrivateChat() {
    Get.toNamed(
        "${RouteConfig.privateChat}?id=${state.details.userId}&name=${state.details.userInfo.nickname}");
  }
}
