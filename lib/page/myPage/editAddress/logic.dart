import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/receiving.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'state.dart';

/// 编辑地址的逻辑层
class EditAddressLogic extends GetxController {
  EditAddressState state = EditAddressState();

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      state.id = Get.arguments;
    }
    /// 获取自身地址
    obtainAddress();
  }

  @override
  void onReady() {
    super.onReady();
    if (Get.arguments != null) {
      /// 获取收货地址信息
      userDeliveryById();
    }
  }

  @override
  void onClose() {
    super.onClose();
    state.nController.dispose();
    state.pController.dispose();
    state.aController.dispose();
  }

  /// 编辑地址
  userDeliverySave() {
    /// 数据过滤
    String value = dataFiltering();

    if (value != "") {
      /// 自定义提示框
      CustomToast.showToast(value, const Color.fromRGBO(255, 77, 96, 1));
      return;
    }

    /// 发起请求
    ReceivingRequest.userDeliverySave(
      address: state.address,
      phone: state.phone,
      areaAddress: state.areaAddress,
      contact: state.contact,
      defaultStatus: state.isChecked ? 1 : 0,
      success: (data) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back(result: "success");
        });
      },
      fail: (code, msg) {},
    );
  }

  /// 数据过滤
  String dataFiltering() {
    String msg = "";
    if (state.address == "") msg = "详细地址不能为空";
    if (state.areaAddress == "请选择地区") msg = "所在地区不能为空";
    if (state.phone == "") msg = "手机号码不能为空";
    if (state.contact == "") msg = "收货人不能为空";

    return msg;
  }

  /// 获取收货地址信息
  userDeliveryById() {
    /// 发起请求
    ReceivingRequest.userDeliveryById(
      id: state.id,
      success: (data) {
        state.address = data.address;
        state.aController.text = data.address;
        state.pController.text = data.phone;
        state.nController.text = data.contact;
        state.phone = data.phone;
        state.contact = data.contact;
        state.areaAddress = data.areaAddress;

        state.isChecked = data.defaultStatus == 1 ? true : false;
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 获取自身地址
  obtainAddress() async {
    var value = await SpUtil.getAddress();
    if (value != null) {
      print("获取到的地址信息${value.adCode}");

      state.adCode = value.adCode;
    }
  }

  /// 选择城市
  void selectCity(BuildContext context) async {
    /// 打开城市选择器
    Result? result = await CityPickers.showFullPageCityPicker(
      context: context,

      /// 主题颜色配置
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

            /// AppBar 标题样式
            titleTextStyle: TextStyle(
              color: const Color.fromRGBO(223, 226, 235, 1),
              fontFamily: "PingFang SC",
              fontSize: 36.dp,
            ),
          ),

          /// 主体背景颜色
          backgroundColor: const Color.fromRGBO(7, 17, 20, 1),

          /// 下划线颜色
          dividerColor: const Color.fromRGBO(17, 22, 24, 1),

          /// 列表文本颜色和选择颜色
          listTileTheme: const ListTileThemeData(
            selectedColor: Colors.white,
            textColor: Color.fromRGBO(115, 117, 124, 1),
          ),

          /// 墨水颜色
          splashColor: Colors.transparent,

          /// ✔的颜色
          primaryColor: Colors.white),

      /// 地区码
      locationCode: state.adCode,
    );
    print("这是选择返回的地址${result}");

    if (result == null) return;

    String province = result.provinceName!.substring(0, 2);

    String name = result.provinceName!;

    if (province == "香港" ||
        province == "澳门" ||
        province == "广西" ||
        province == "内蒙" ||
        province == "宁夏" ||
        province == "新疆") {
      name = province;
    }

    /// 赋值
    state.areaAddress = "$name,${result.cityName!},${result.areaName!}";

    update();
  }

  /// switch开关改变
  void onChanged(bool value) {
    print("switch开关改变=======>   $value");
    state.isChecked = value;
    update();
  }

  /// 名字改变
  void contactChange(String msg) {
    print("名字改变输入框输入的内容=======>   $msg");
    state.contact = msg;
    update();
  }

  /// 手机号码改变
  void phoneChange(String msg) {
    print("手机号码改变输入框输入的内容=======>   $msg");
    state.phone = msg;
    update();
  }

  /// 详细地址改变
  void addressChange(String msg) {
    print("详细地址改变输入框输入的内容=======>   $msg");
    state.address = msg;
    update();
  }
}
