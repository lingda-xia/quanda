import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/api/imageUpload.dart';
import 'package:quanda/api/personal.dart';
import 'package:quanda/router/router.dart';
import 'state.dart';

/// 反馈的逻辑层
class FeedbackLogic extends GetxController {
  FeedbackState state = FeedbackState();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.textController.dispose();
  }

  /// 建议反馈添加
  feedBackSave() {
    /// 发送请求
    PersonalRequest.feedBackSave(
      content: state.textContent,
      mobile: state.phone,
      imageId: state.idList,
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

          /// 将id提前出来   用于接口上传
          for (int i = 0; i < data.length; i++) {
            state.idList.add(data[i].id);
          }

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

  /// 监听搜索输入
  void onChanged(String msg) {
    print("输入框输入的内容=======>   $msg");
    state.textContent = msg;
    update();
  }

  /// 手机号码输入
  void changPhone(String msg) {
    print("手机号码输入的内容=======>   $msg");
    state.phone = msg;
    update();
  }

  /// 前往历史反馈页
  void goToHistoricalFeedback() {
    Get.toNamed(RouteConfig.historicalFeedback);
  }
}
