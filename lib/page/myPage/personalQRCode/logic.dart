import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/model/user/UserInfo.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'state.dart';

/// 个人二维码的逻辑层
class PersonalQRCodeLogic extends GetxController {
  PersonalQRCodeState state = PersonalQRCodeState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    /// 获取用户信息
    getUserInfo();

    /// 获取二维码使用权限
    getSettingItem();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 获取二维码使用权限
  getSettingItem() {
    /// 发起请求
    PersonalRequest.getSettingItem(
      key: "qrcode_status",
      success: (data) {
        state.qrcodeStatus = data["qrcodeStatus"];
        update();
      },
      fail: (code, msg) {},
    );
  }

  /// 获取用户信息
  getUserInfo() async {
    UserInfo? value = SpUtil.getUserInfo();
    if (value != null) {
      state.info = value;
      update();
    }
  }

  /// 请求权限
  Future<void> requestPermission(QrPainter value) async {
    /// 检测权限
    var status = await Permission.storage.status;

    /// 已经授权
    if (status == PermissionStatus.granted) {
      /// 保存图片
      savePicture(value);
    } else {
      /// 未授权则发起一次申请
      status = await Permission.storage.request();

      /// 授权通过
      if (status == PermissionStatus.granted) {
        /// 保存图片
        savePicture(value);
      } else {}
    }
  }

  /// 保存图片
  void savePicture(QrPainter value) async {
    var byteData = await value.toImageData(500);
    var pngBytes = byteData?.buffer.asUint8List();

    /// 保存
    final result = await ImageGallerySaver.saveImage(pngBytes!,
        quality: 100, name: "QRCode");
    print("这是保存之后的结果$result");
  }

  /// 关闭页面
  void closePage() {
    Get.back();
  }
}
