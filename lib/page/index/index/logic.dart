import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quanda/api/index.dart';
import 'package:quanda/api/interaction.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/model/LongList.dart';
import 'package:quanda/model/index/Recommend.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'state.dart';
import 'dart:math';
import 'package:barcode_scan2/barcode_scan2.dart';

/// 首页 逻辑层
class IndexLogic extends GetxController {
  IndexState state = IndexState();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void init() async {
    /// 获取定位信息
    await getLocation();

    /// 计算坐标
    calculation();
  }

  /// 获取推荐列表
  Future<LongList> getList(int type, int page) {
    /// 等待请求完成
    Completer<LongList> completer = Completer();

    /// 发起请求
    IndexRequest.homePageDataList(
        lat: state.address.latitude.toString(),
        lon: state.address.longitude.toString(),
        type: type,
        page: page,
        success: (data) {
          /// 重置列表状态关闭
          state.reload[type] = false;
          /// 列表数据
          List res = data.records;

          List<Recommend> list = [];
          for (int i = 0; i < res.length; i++) {
            list.add(Recommend.fromJson(res[i]));
          }

          if (data.current == 1) {
            state.listMap[type] = list;
          } else {
            state.listMap[type]?.addAll(list);
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
        });

    return completer.future;
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

  /// 获取定位信息
  getLocation() async {
    var value = await SpUtil.getAddress();
    if (value == null) return;
    state.city = value.city;
    state.district = value.district;
    state.address = value;
    update();
  }

  /// 扫码二维码
  Future<void> scanQRCode() async {
    try {
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
        /// 识别不同的二维码
        bool value = result.rawContent.contains("userId");

        /// 是否包含用户id
        if(value) {
          /// 解析二维码的内容
          List<String> list = result.rawContent.split("=");
          /// 前往他人主页
          goToOthers(list[1]);
        } else {
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
  orderCheckSave(int id, String code, int rid, int type) async {
    /// 发起请求
    InteractionRequest.orderCheckSave(
      sourceOrderId: id,
      checkCode: code,
      success: (data) {
        /// 打开成功提示对话框
        openDialog(rid, type);
      },
      fail: (code, msg) {
        /// 打开失败提示对话框
        openFailDialog();
      },
    );
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

  /// 设置tab下标
  void setIndex(int index) {
    state.index = index;

    update();
  }

  /// 区间生成随机数
  int next(int min, int max) {
    int res = min + Random().nextInt(max - min);
    return res;
  }

  /// 计算坐标
  void calculation() {
    int dx = next(0, 650);
    int dy = next(0, 560);

    /// 在这个区间的
    if (40 < dx &&
        dx < 570 &&
        ((0 < dy && dy < 50) || (550 < dy && dy < 560))) {
      // print("X == $dx    Y == $dy");
      /// 与坐标列表里的每一个坐标比较距离
      if (state.list.isNotEmpty) {
        /// 它们的间隔大于85
        bool value = state.list.every((item) {
          double distanceTo = Point(item.dx, item.dy).distanceTo(Point(dx, dy));
          return distanceTo > 85.0;
        });

        /// 如果是就将坐标添加进去
        if (value) {
          Coordinate value = Coordinate(
            dx: dx,
            dy: dy,
          );
          state.list.add(value);
        }
      } else {
        Coordinate value = Coordinate(
          dx: dx,
          dy: dy,
        );
        state.list.add(value);
      }
    } else if (((30 < dx && dx < 100) || (575 < dx && dx < 650)) &&
        0 < dy &&
        dy < 560) {
      // print("X == $dx    Y == $dy");
      if (state.list.isNotEmpty) {
        bool value = state.list.every((item) {
          double distanceTo = Point(item.dx, item.dy).distanceTo(Point(dx, dy));
          return distanceTo > 110.0;
        });

        if (value) {
          Coordinate value = Coordinate(
            dx: dx,
            dy: dy,
          );
          state.list.add(value);
        }
      } else {
        Coordinate value = Coordinate(
          dx: dx,
          dy: dy,
        );
        state.list.add(value);
      }
    }

    if (state.list.length < state.areaList.length) {
      calculation();
    } else {
      update();
    }
  }

  /// 前往任务人列表
  void goToTaskList(int id) {
    Get.toNamed(RouteConfig.taskList, arguments: id);
  }

  /// 前往闲置详情页面
  void goToIdleOrderDetails(int id) {
    Get.toNamed(RouteConfig.idleOrderDetails, arguments: id.toString());
  }

  /// 前往他人主页
  void goToOthers(String id) {
    Get.toNamed("${RouteConfig.others}?id=$id");
  }

  /// 前往查看详情页
  void goToSeeDetails(String id) {
    Get.toNamed("${RouteConfig.seeDetails}?id=$id");
  }

  /// 前往搜索框
  void goToSearchBox() {
    Get.toNamed(RouteConfig.searchBox);
  }
}
