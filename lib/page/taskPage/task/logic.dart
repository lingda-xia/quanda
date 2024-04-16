import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/task.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/task/DailyTask.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';
import 'widget/withdrawalPopup.dart';

/// 任务 的逻辑层
class TaskLogic extends GetxController {
  TaskState state = TaskState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取任务中心信息
    getTaskCoreInfo();

    /// 获取日常任务
    getDailyTask();

    /// 获取推荐任务
    getRecommendTask();
  }

  /// 获取任务中心信息
  getTaskCoreInfo() {
    /// 发起请求
    TaskRequest.taskCoreInfo(
        success: (data) {
          state.data = data;
          state.signList = data.firstSignData;

          if(data.firstSignData.isNotEmpty) {
            /// 时间转换
            String str = timeChange(data.firstSignData[0]!.signTime,
                data.firstSignData[data.firstSignData.length - 1]!.signTime);
            state.timeLimit = str;
            update();
            /// 打开提现弹窗
            openWithdrawalPopup();
          }
        },
        fail: (code, msg) {});
  }

  /// 时间转换
  String timeChange(String one, String two) {
    /// 时间戳转时间
    final start = DateTime.fromMillisecondsSinceEpoch(int.parse(one));
    final end = DateTime.fromMillisecondsSinceEpoch(int.parse(two));

    String str = "${start.month}.${start.day}-${end.month}.${end.day}";
    return str;
  }

  /// 获取日常任务
  getDailyTask() {
    /// 发起请求
    TaskRequest.dailyTaskInfo(
        success: (data) {
          state.dailyTaskList = data;
          update();
        },
        fail: (code, msg) {});
  }

  /// 获取推荐任务
  getRecommendTask() async {
    /// 获取地址信息
    Address value = await SpUtil.getAddress();

    /// 发起请求
    TaskRequest.recommendTaskList(
        lon: value.longitude.toString(),
        lat: value.latitude.toString(),
        success: (data) {
          state.recommendList = data;
          update();
        },
        fail: (code, msg) {});
  }

  /// 限时签到领红包
  signRedPackage() async {
    /// 发起请求
    TaskRequest.signRedPackage(success: (data) {}, fail: (code, msg) {});
  }

  /// 打开提现弹窗
  void openWithdrawalPopup() {
    Get.dialog(
      WithdrawalPopup(
        data: state,
        onTap: () {
          Get.back();

          /// 前往提现
          goToWithdrawal();
        },
      ),
    );
  }

  /// 前往页面
  void goTo(int i) {

  }

  /// 前往收益说明
  void goToIncomeStatement() {
    Get.toNamed(RouteConfig.incomeStatement);
  }

  /// 前往提现
  void goToWithdrawal() {
    Get.toNamed(RouteConfig.withdrawal);
  }

  /// 前往 金币收益
  void goToGoldIncome() {
    Get.toNamed(RouteConfig.goldIncome);
  }
}
