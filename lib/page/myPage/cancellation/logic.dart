import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/api/imageUpload.dart';
import 'package:quanda/api/login.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/custom_toast.dart';
import 'state.dart';

/// 注销原因的逻辑层
class CancellationLogic extends GetxController {
  CancellationState state = CancellationState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 注销账号
  logoutUser() {
    /// 注销原因
    String reason = "";

    if (state.selectIndex != 2) {
      reason = state.reasonList[state.selectIndex];
    } else {
      reason = state.textContent;
      if (state.textContent.isEmpty) {
        CustomToast.showToast("输入内容不能为空", const Color.fromRGBO(255, 77, 96, 1));
        return;
      }
    }

    /// 发起请求
    LoginRequest.logoutUser(
      reason: reason,
      imageId: state.galleryItems.isNotEmpty ? state.galleryItems[0].id : null,
      success: (data) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          Get.back();
        });
      },
      fail: (code, msg) {},
    );
  }

  /// 选择图片
  void selectImg() async {
    try {
      /// 多图片选择器
      final XFile? pickedFile = await state.picker.pickImage(
        source: ImageSource.gallery,
      );

      List<XFile>? list = [];
      list.add(pickedFile!);

      print("这是选择图片的返回${pickedFile}");

      /// 上传接口
      ImageUpload.upload(
        list,
        success: (data) {
          state.galleryItems.addAll(data);
          update();
        },
        fail: (code, msg) {},
      );
    } catch (e) {
      print("多图片选择器出现了错误$e");
    }
  }

  /// 删除图片
  void deleteImg(int index) {
    state.galleryItems.removeAt(index);
    update();
  }

  /// 选择原因
  void selectReason(int index) {
    state.selectIndex = index;
    update();
  }

  /// 监听搜索输入
  void onChanged(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }
}
