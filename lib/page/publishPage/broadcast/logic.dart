import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/location/RadioParam.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/payment_popup.dart';
import 'state.dart';

/// 发布广播的逻辑层
class BroadcastLogic extends GetxController {
  BroadcastState state = BroadcastState();

  @override
  void onInit() {
    super.onInit();
    initMoney();
  }

  /// 发布广播
  /// [title] 标题
  /// [content] 内容
  /// [address] 地址信息
  /// [location] 经纬度
  /// [idList] 图片id列表
  void release(String title, String content, String address, String location,
      List<String> idList) {
    /// 数据过滤
    String value = dataFiltering(title, content, idList);

    if (value != "") {
      /// 自定义提示框
      CustomToast.showToast(value, const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 字符串分割  将经纬度拆开
    List<String> lst = location.split(",");

    print("得到的经纬度$location");
    print("得到的经纬度$lst");

    /// 发起请求
    PublishRequest.publishBroadcast(

        /// [title] 标题
        title: title,
        /// [address] 地址名称
        address: address,
        /// [lon] 经度
        lon: lst[0],

        /// [lat] 纬度
        lat: lst[1],
        /// [content] 正文内容
        content: content,
        /// [media] 媒体列表
        media: idList,
        /// [payMoney] 需要支付的总金额
        payMoney: state.payMoney,
        /// [rangeKm] 多少公里数可看
        rangeKm: state.kilometers,
        /// [broadcastTime] 广播时长
        broadcastTime: state.times * 60,
        goldType: state.goldType,
        success: (data) async {
          /// 需要支付
          if(!data["payFlag"]) {
            await openPayment(data["id"]);
            /// 返回首页
            Future.delayed(const Duration(milliseconds: 1000)).then((e) {
              Get.offAllNamed("/");
            });
          } else {
            /// 返回首页
            Future.delayed(const Duration(milliseconds: 1000)).then((e) {
              Get.offAllNamed("/");
            });
          }
        },
        fail: (code, e) {});
  }

  /// 弹起支付订单弹窗
  openPayment(int orderId) async {
    await Get.bottomSheet(
      /// 支付弹窗 自定义widget
      PaymentOrder(
        money: state.payMoney.toString(),
        module: "release",
        orderId: orderId,
      ),

      /// 蒙层颜色
      barrierColor: const Color.fromRGBO(7, 17, 20, 0.84),

      /// 设置圆角  圆角矩形
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.dp),
          topLeft: Radius.circular(40.dp),
        ),
      ),
      backgroundColor: blackGrey,
    );
  }

  /// 数据过滤
  String dataFiltering(String title, String content, List<String> idList) {
    String msg = "";
    if (idList.isEmpty) msg = "图片列表不能为空";
    if (content == "") msg = "内容不能为空";
    if (title.characters.length < 6) msg = "标题字数不能小于六个字";

    return msg;
  }

  /// 存草稿
  /// [title] 标题
  /// [content] 内容
  /// [address] 地址信息
  /// [location] 经纬度
  /// [galleryItem] 图片列表
  void saveDraft(String title, String content, String address, String location,
      List<ImgEntity> galleryItem, int status) async {
    /// 字符串分割  将经纬度拆开
    List<String> lst = location.split(",");

    /// 图片id列表
    List<String> idList = [];

    /// 将图片id提前出来   用于接口上传
    for(int i = 0; i < galleryItem.length; i++){
      idList.add(galleryItem[i].id.toString());
    }

    /// 任务参数
    RadioParam radioParam = RadioParam(
      /// [title] 标题
      title,

      /// [address] 地址名称
      address,

      /// [lon] 经度
      lst[0],

      /// [lat] 纬度
      lst[1],

      /// [content] 正文内容
      content,

      /// [media] 媒体列表 只有id
      idList,

      /// [imgList] 图片列表  地址加id
      galleryItem,

      /// [payMoney] 需要支付的总金额
      state.payMoney,

      /// [rangeKm] 多少公里数可看
      state.kilometers,

      /// [broadcastTime] 广播时长
      state.times,

      /// 选择的是图片还是视频 或者没选择  0 未选择 1 选择图片 2 选择视频
      status,
    );

    String value = jsonEncode(radioParam);

    /// 保存草稿  广播参数
    await SpUtil.saveDraft(value, "radioParam");

    /// 自定义提示框
    CustomToast.showToast("保存成功", paleGreenColor);
  }

  /// 将草稿内容赋值
  void setContent(RadioParam value) {
    state.media = value.media;
    state.kilometers = value.rangeKm;
    state.times = value.broadcastTime;
    state.payMoney = value.payMoney;

    update();
  }

  /// 初始化 发布所需圈达币
  void initMoney() {
    /// 将总数保留两位小数
    String str =
    (state.times * 60 * 0.1 + state.kilometers).toStringAsFixed(2);

    /// 总所需圈达币   广播展示时长*60*0.1 + 公里内可见*1
    state.payMoney = double.parse(str);
  }

  /// 初始化对话框 提示是否使用草稿
  initDialog() async {
    /// 获取草稿  广播参数
    var value = await SpUtil.getDraft("radioParam");

    /// 未存有草稿
    if (value == null) return null;

    /// 广播参数
    RadioParam radioParam = RadioParam.fromJson(value);

    return radioParam;
  }

  /// 公里数变化
  void kilometersChange(double value) {
    print("公里数变化 ------------ ${value.round()}");
    state.kilometers = value.round().toDouble();

    /// 将总数保留两位小数
    String str = (state.times * 60 * 0.1 + value.round().toDouble())
        .toStringAsFixed(2);

    /// 总所需圈达币   广播展示时长*60*0.1 + 公里内可见*1
    state.payMoney = double.parse(str);

    update();
  }

  /// 时长数变化
  void timesChange(double value) {
    print("时长数变化 ------------ $value");
    state.times = value;

    /// 将总数保留两位小数
    String str = (value * 60 * 0.1 + state.kilometers).toStringAsFixed(2);

    /// 总所需圈达币  广播展示时长*60*0.1 + 公里内可见*1
    state.payMoney = double.parse(str);
    update();
  }

}
