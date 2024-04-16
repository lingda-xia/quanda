import 'dart:async';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quanda/api/interaction.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'state.dart';

/// 我的互动的逻辑层
class MyInteractionLogic extends GetxController {
  MyInteractionState state = MyInteractionState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 获取互动列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    PublishRequest.getReleaseList(
        type: type,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload = false;

          List res = data.records;

          List<ReleaseList> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(ReleaseList.fromJson(res[i]));
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
        },);

    return completer.future;
  }

  /// 打开删除弹窗
  openDeleteDialog(int id) {
    Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => releaseDel(id.toString()),

        /// 内容
        content: "是否确认删除，删除后将无法恢复",

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "确认",
      ),

      /// 是否关闭蒙层
      barrierDismissible: false,
    );
  }

  /// 删除互动
  releaseDel(String id) {
    /// 发起请求
    InteractionRequest.releaseDel(
      id: id,
      success: (data) {
        /// 重置列表状态开启
        state.reload = true;
        update();
      },
      fail: (code, msg) {},
    );
    update();
  }

  /// 是否主动结束任务
  releaseTaskEnd(int id) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () {
          /// 发起请求
          InteractionRequest.releaseTaskEnd(
              id: id.toString(),
              success: (data) {
                /// 重新获取列表
                getList(0, 1);
              },
              fail: (code, msg) {});
        },

        /// 内容
        content: "是否需要结束该任务",

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "确认",
      ),

      /// 是否关闭蒙层
      barrierDismissible: false,
    );
  }

  /// 核验
  /// [id] 互动id
  /// [type] 互动类型
  void verification() async {
    try {
      /// 打开扫描二维码
      final result = await BarcodeScanner.scan(
        options: const ScanOptions(
          strings: {
            'cancel': "关闭",
            'flash_on': "打开闪光灯",
            'flash_off': "关闭闪光灯",
          },

          /// 限制可识别的格式
          restrictFormat: [BarcodeFormat.qr],

          /// 用于扫描的相机的索引
          useCamera: -1,

          /// 开始扫描时启用闪光灯
          autoEnableFlash: false,
          android: AndroidOptions(
            /// 在 Android 上启用自动对焦
            aspectTolerance: 0.5,

            /// 设置用于计算最佳相机预览大小的纵横比容差级别
            useAutoFocus: true,
          ),
        ),
      );

      print("这是扫码输出的内容-------${result.rawContent}");

      if (result.rawContent.isNotEmpty) {
        /// 解析二维码的内容
        List<String> list = result.rawContent.split(",");

        /// code验证码
        String code = list[0].split("=")[1];

        /// 源订单id
        String id = list[1].split("=")[1];

        /// 发布id
        String rid = list[2].split("=")[1];

        /// 发布类型 1=任务 2=闲置
        String type = list[3].split("=")[1];

        print("id$id--code$code--发布id$rid---发布类型$type---");

        /// 订单核验
        orderCheckSave(int.parse(id), code, int.parse(rid), int.parse(type));
      }
    } on PlatformException catch (e) {
      ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? '用户未授予摄像机权限！'
            : '未知的错误: $e',
      );
    }
  }

  /// 订单核验
  /// [id] 源订单id 接口所需
  /// [code] 验证码 接口所需
  /// [hid] 互动id 跳转页面所需
  /// [type] 互动类型 1=任务 2=闲置
  orderCheckSave(int id, String code, int rid, int type) {
    /// 发起请求
    InteractionRequest.orderCheckSave(
        sourceOrderId: id,
        checkCode: code,
        success: (data) async {
          /// 获取互动列表
          await getList(0, 1);

          /// 打开成功提示对话框
          openDialog(rid, type);
        },
        fail: (code, msg) {
          /// 打开失败提示对话框
          openFailDialog();
        });
  }

  /// 打开成功提示对话框
  /// [hid] 互动id 跳转页面所需
  /// [type] 互动类型 1=任务 2=闲置
  Future openDialog(int rid, int type) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () {
          if (type == 2) {
            /// 前往闲置详情页面
            goToIdleOrderDetails(rid);
          } else {
            /// 前往任务人列表
            goToTaskList(rid);
          }
        },

        /// 取消事件
        cancel: () {
          if (type == 2) {
            /// 前往闲置详情页面
            goToIdleOrderDetails(rid);
          } else {
            /// 前往任务人列表
            goToTaskList(rid);
          }
        },

        /// 内容
        content: "核验成功",

        /// 取消文本
        cancelText: "关闭",

        /// 确认文本
        confirmText: "确定",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 打开失败提示对话框
  Future openFailDialog() async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => {},

        /// 内容
        content: "核验失败",

        /// 内容的文本颜色
        color: const Color.fromRGBO(255, 69, 69, 1),

        /// 提示内容
        tips: "该订单已结束",

        /// 取消文本
        cancelText: "取消",

        /// 确认文本
        confirmText: "继续核验",
      ),

      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 前往查看详情页
  void goToSeeDetails(String id) {
    Get.toNamed("${RouteConfig.seeDetails}?id=$id");
  }

  /// 前往任务人列表
  void goToTaskList(int id) {
    Get.toNamed(RouteConfig.taskList, arguments: id);
  }

  /// 前往闲置详情页面
  void goToIdleOrderDetails(int id) {
    Get.toNamed(RouteConfig.idleOrderDetails, arguments: id.toString());
  }
}
