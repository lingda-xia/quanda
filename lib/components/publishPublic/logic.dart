import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quanda/api/imageUpload.dart';
import 'package:quanda/model/location/Address.dart';
import 'package:quanda/router/router.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/save/sp_util.dart';
import 'package:quanda/widget/custom_dialog.dart';
import 'package:video_player/video_player.dart';
import 'state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quanda/model/location/SearchResult.dart';
import 'package:quanda/model/ImgEntity.dart';

/// 发布公用部分  的逻辑层
class PublishPublicLogic extends GetxController {
  PublishPublicState state = PublishPublicState();

  @override
  void onInit() {
    obtainAddress();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    state.video.dispose();
  }

  /// 打开是否保存草稿对话框
  Future openDialog(Function saveDraft) async {
    await Get.dialog(
      /// 自定义对话框
      CustomDialog(
        /// 确认事件
        confirm: () => saveDraft(),
        /// 内容
        content: "未发布完 是否保存草稿",
        /// 取消文本
        cancelText: "放弃草稿",
        /// 确认文本
        confirmText: "保存",
      ),
      /// 打开蒙层
      barrierDismissible: false,
    );
    // await Future.delayed(const Duration(milliseconds: 2000));
  }

  /// 数据过滤 用于返回时提示是否保存草稿
  bool dataFiltering() {
    bool value = false;
    if (state.title == "" && state.content == "" && state.galleryItems.isEmpty) value = true;
    return value;
  }

  /// 使用草稿
  /// value   草稿的数据
  applyDraft(dynamic value, AParameterCallback setContent) {
    Get.dialog(
      CustomDialog(
        /// 确认事件
        confirm: () {
          /// 将图片列表赋值
          List<ImgEntity> list = [];
          value.imgList.forEach((e) {
            ImgEntity a = ImgEntity.fromJson(e);
            list.add(a);
          });
          /// 确认之后将赋值出去
          state.titleController.text = value.title;
          state.contentController.text = value.content;
          state.title = value.title;
          state.content = value.content;
          state.galleryItems = list;
          state.displayedLocation = value.address;
          state.positional = value.lon + "," + value.lat;
          state.idList = value.media;
          state.status = value.status;
          /// 父组件的设置内容方法
          setContent(value);

          update();
        },
        /// 内容
        content: "您有未编辑完的发布是否继续编辑",
        /// 取消文本
        cancelText: "放弃",
        /// 确认文本
        confirmText: "继续",
      ),
      /// 打开蒙层
      barrierDismissible: false,
    );
  }

  /// 获取地址 初始化
  obtainAddress() async {
    Address value = await SpUtil.getAddress();
    /// 自身的定位信息
    state.address = value;
    /// 需要显示的地址的经纬度
    state.positional = "${value.longitude},${value.latitude}";
    /// 需要显示的地址
    // state.displayedLocation = value.city + value.district + value.address;
    state.displayedLocation = value.address;
    update();
  }

  /// 选择图片
  void selectImg() async {
    try {
      /// 多图片选择器
      final List<XFile>? pickedFileList = await state.picker.pickMultiImage(
      );
      print("这是选择图片的返回${pickedFileList![0].path}");

      /// 上传接口
      ImageUpload.upload(pickedFileList, success: (data) {
        state.galleryItems.addAll(data);
        /// 将图片id提前出来   用于接口上传
        for(int i = 0; i < data.length; i++){
          state.idList.add(data[i].id.toString());
        }
        update();
      }, fail: (code, msg) {
        /// 如果列表为空  切换会添加状态
        if(state.galleryItems.isEmpty) {
          /// 重置添加状态
          state.status = 0;
        }
        update();
      });
    } catch (e) {
      /// 如果列表为空  切换会添加状态
      if(state.galleryItems.isEmpty) {
        /// 重置添加状态
        state.status = 0;
      }
      update();
      print("多图片选择器出现了错误$e");
    }
  }

  /// 选择视频
  void selectVideo() async {
    try {
      /// 视频选择器
      final XFile? pickedFile= await state.picker.pickVideo(
        source: ImageSource.gallery,
      );

      List<XFile>? list = [];
      list.add(pickedFile!);

      print("这是选择视频的返回${pickedFile}");

      /// 上传接口
      ImageUpload.upload(list, success: (data) {
        state.galleryItems.addAll(data);
        /// 将id提前出来   用于接口上传
        for(int i = 0; i < data.length; i++){
          state.idList.add(data[i].id.toString());
        }

        state.video = VideoPlayerController.network(data[0].filePath)
          ..initialize().then((_) {
            update();
          });

        update();
      }, fail: (code, msg) {
        /// 重置添加状态
        state.status = 0;
        update();
      });
    } catch (e) {
      /// 重置添加状态
      state.status = 0;
      update();
      print("多图片选择器出现了错误$e");
    }
  }

  /// 删除图片
  void deleteImg(int index) {
    state.galleryItems.removeAt(index);
    /// 当图片列表为空时
    if(state.galleryItems.isEmpty) {
      state.status = 0;
    }
    update();
  }

  /// 前往选择地址
  goToSelectAddress() async {
    var data = await Get.toNamed(RouteConfig.addressSelect);
    if(data != null) {
      /// 转回实体类
      var value = SearchResult.fromJson(jsonDecode(data));
      /// 选择返回的地址
      state.returnedAddress = value;
      /// 需要显示的地址
      state.displayedLocation = value.city + value.district + value.name;
      /// 需要显示的地址的经纬度
      state.positional = value.location;
    }
    update();
  }

  /// 选择图片还是视频
  onSelect(int value) {
    state.status = value;
    update();
  }

  /// 标题输入变化
  void titleChange(String msg) {
    print("标题输入的内容是 ------------ $msg");
    state.title = msg;
    update();
  }

  /// 内容输入变化
  void contentChange(String msg) {
    print("内容输入的内容是 ------------ $msg");
    state.content = msg;
    update();
  }

  /// 前往视频预览
  void goToVideoPreview() {
    Get.toNamed(RouteConfig.videoPreview,arguments: state.galleryItems[0].filePath);
  }
}
