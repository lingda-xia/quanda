import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/api/receiving.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/location/SetAsideParam.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/color.dart';
import 'state.dart';

/// 发布闲置 的逻辑层
class SetAsideLogic extends GetxController {
  SetAsideState state = SetAsideState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 初始化对话框 提示是否使用草稿
  initDialog() async {
    /// 获取草稿  闲置参数
    var value = await SpUtil.getDraft("setAsideParam");

    /// 未存有草稿
    if (value == null) return null;

    /// 闲置参数
    SetAsideParam setAsideParam = SetAsideParam.fromJson(value);

    return setAsideParam;
  }

  /// 发布任务
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
    PublishRequest.publishSetAside(

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
        payMoney: int.parse(state.payMoney),

        /// [extractType] 提取方式 1=上门自提 2=我出邮费 3=你出邮费
        extractType: state.extractType + 1,

        /// 上门自提需要 提货地址id
        deliveryId: state.address.id,

        goldType: state.goldType,

        success: (data) {
          /// 返回首页
          Future.delayed(const Duration(milliseconds: 2000)).then((e) {
            Get.offAllNamed("/");
          });
        },
        fail: (code, e) {});
  }

  /// 数据过滤
  String dataFiltering(String title, String content, List<String> idList) {
    String msg = "";
    if (idList.isEmpty) msg = "图片列表不能为空";
    if (content == "") msg = "内容不能为空";
    if (title.characters.length < 6) msg = "标题字数不能小于六个字";
    if (state.extractType == 0 && state.address.id == 0) msg = "请选择提货地址";

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
    for (int i = 0; i < galleryItem.length; i++) {
      idList.add(galleryItem[i].id.toString());
    }

    /// 闲置参数
    SetAsideParam setAsideParam = SetAsideParam(
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

      /// [extractType] 提取方式 1=上门自提 2=我出邮费 3=你出邮费
      state.extractType,

      status,
    );

    String value = jsonEncode(setAsideParam);

    /// 保存草稿  闲置参数
    await SpUtil.saveDraft(value, "setAsideParam");

    /// 自定义提示框
    CustomToast.showToast("保存成功", paleGreenColor);
  }

  /// 将草稿内容赋值
  void setContent(SetAsideParam value) {
    state.payMoney = value.payMoney;
    state.extractType = value.extractType;
    state.textController.text = value.payMoney;

    update();
  }

  /// 获取收货地址信息
  userDeliveryById(int id) {
    /// 发起请求
    ReceivingRequest.userDeliveryById(
      id: id,
      success: (data) {
        state.address = data;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 价格输入变化
  void priceChange(String msg) {
    state.payMoney = msg;
    update();
  }

  /// 选中的提取方式
  void selectIndex(int index) {
    state.extractType = index;
    update();
  }

  /// 前往地址管理页面
  void goToAddressManage() async {
    var data = await Get.toNamed(RouteConfig.addressManage);
    if(data != null) {
      /// 获取收货地址信息
      userDeliveryById(data);
    }
  }
}
