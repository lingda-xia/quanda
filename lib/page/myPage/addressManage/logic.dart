import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/api/receiving.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 地址管理的逻辑层
class AddressManageLogic extends GetxController {
  AddressManageState state = AddressManageState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    /// 获取收货列表
    userDeliveryList();
  }

  /// 获取收货列表
  userDeliveryList() {
    /// 发起请求
    ReceivingRequest.userDeliveryList(
      success: (data) {
        state.list = data;
        /// 默认地址
        for(int i = 0; i < data.length; i++) {
          if(data[i].defaultStatus == 1) {
            state.selectId = data[i].id;
          }
        }
        update();
      },
      fail: (code, msg) {

      },
    );
  }

  /// 选择地址
  select(int id) {
    state.selectId = id;
    update();
    Get.back(result: id);
  }

  /// 前往编辑地址页面
  void goToEditAddress([id]) async {
    var data = await Get.toNamed(RouteConfig.editAddress, arguments: id);
    if(data == "success") {
      /// 获取收货列表
      userDeliveryList();
    }
  }

}
