import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/publish.dart';
import 'package:quanda/model/ImgEntity.dart';
import 'package:quanda/model/location/DynamicParam.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';
import 'package:quanda/utils/ui/color.dart';

/// 发布瞬间 的逻辑层
class PublishDynamicLogic extends GetxController {
  PublishDynamicState state = PublishDynamicState();

  @override
  void onInit() {
    super.onInit();
  }

  /// 初始化对话框 提示是否使用草稿
  initDialog() async {
    /// 获取草稿  瞬间参数
    var value = await SpUtil.getDraft("dynamicParam");

    /// 未存有草稿
    if (value == null) return null;

    /// 瞬间参数
    DynamicParam dynamicParam = DynamicParam.fromJson(value);

    return dynamicParam;
  }

  /// 发布瞬间
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
    PublishRequest.publishDynamic(

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
    DynamicParam dynamicParam = DynamicParam(
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

      /// 选择的是图片还是视频 或者没选择  0 未选择 1 选择图片 2 选择视频
      status,
    );

    String value = jsonEncode(dynamicParam);

    /// 保存草稿  瞬间参数
    await SpUtil.saveDraft(value, "dynamicParam");

    /// 自定义提示框
    CustomToast.showToast("保存成功", paleGreenColor);
  }

  /// 将草稿内容赋值
  void setContent(DynamicParam value) {

    update();
  }

}
