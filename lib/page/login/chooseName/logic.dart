import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/user.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/page/chatPage/tencent_im/logic.dart';
import 'package:quanda/page/login/chooseBirthday/logic.dart';
import 'package:quanda/page/login/chooseFigure/logic.dart';
import 'package:quanda/page/login/chooseGender/logic.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'state.dart';

/// 选择名称 的逻辑层
class ChooseNameLogic extends GetxController {
  ChooseNameState state = ChooseNameState();

  /// 选择生日
  final time = Get.find<ChooseBirthdayLogic>().state.time;

  /// 选择形象
  final figure = Get.find<ChooseFigureLogic>().state.select;

  /// 选择性别
  final gender = Get.find<ChooseGenderLogic>().state.select;

  /// 腾讯im
  final tim = Get.find<TencentImLogic>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变名称
  void change(String str) {
    state.name = str;
    update();
  }

  /// 确认
  void confirm() async {
    /// 先取消输入框的焦点
    state.focusNode.unfocus();

    if (state.name == "") {
      /// 显示提示框  自定义
      CustomToast.showToast("请填写名称", const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 保存 选择的形象
    SpUtil.saveFigure(figure);

    /// 获取地址信息
    Address address = await SpUtil.getAddress();

    // /// 切割后的城市
    // String province = address.province.substring(0, 2);
    //
    // if (province == "黑龙") {
    //   province = "黑龙江";
    // } else if (province != "香港" || province != "澳门") {
    //   province = "$province省";
    // }

    // print("切割后的省份------$province");
    // print("切割后的省份--========----$province,${address.city},${address.district}");

    /// 获取用户信息
    UserInfo? userInfo = SpUtil.getUserInfo();

    if(userInfo != null) {
      /// 请求保存用户信息
      UserRequest.userInfoSave(
        /// 名称
        nickname: state.name,

        /// 性别
        sex: gender,

        /// 生日
        birthday: "${time.year}-${time.month}-${time.day}",

        /// 地址
        address: "${address.province},${address.city},${address.district}",

        /// 头像
        avatarUrl: userInfo.avatarUrl,

        /// 个人简介
        introduction: "这个家伙很懒，什么都没写哦～",

        success: (data) async {
          /// 腾讯im  修改个人信息
          await tim.setSelfInfo(
            userID: userInfo.userId.toString(),
            name: state.name,
            faceUrl: userInfo.avatarUrl,
            gender: gender,
          );

          /// 成功之后进入首页
          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.offAllNamed(RouteConfig.main);
          });
        },
        fail: (code, msg) {},
      );
    }
  }
}
