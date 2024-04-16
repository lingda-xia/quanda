import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/photo_Gallery.dart';
import 'package:video_player/video_player.dart';

import '../logic.dart';
import '../state.dart';

/// 图片或者视频区域
class ImgOrVideo extends StatelessWidget {
  const ImgOrVideo({
    Key? key,
    required this.logic,
    required this.state,
  }) : super(key: key);

  /// 数据源
  final PublishPublicState state;

  /// 逻辑层
  final PublishPublicLogic logic;

  /// 显示底部弹出框
  void showBottomPopup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 360.dp,
          decoration: BoxDecoration(
              color: blackGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.dp),
                topRight: Radius.circular(40.dp),
              )),
          child: Column(
            children: [
              SizedBox(height: 20.dp),

              /// 添加图片
              GestureDetector(
                onTap: () {
                  Get.back();

                  /// 确定选择的类型  图片
                  logic.onSelect(1);

                  /// 打开图片选择
                  logic.selectImg();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 30.dp),
                  child: Text(
                    "添加图片",
                    style: TextStyle(
                      color: paleGreenColor,
                      fontSize: 34.dp,
                    ),
                  ),
                ),
              ),

              /// 添加视频
              GestureDetector(
                onTap: () {
                  Get.back();

                  /// 确定选择类型 视频
                  logic.onSelect(2);

                  /// 打开视频选择
                  logic.selectVideo();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 30.dp),
                  child: Text(
                    "添加视频",
                    style: TextStyle(
                      color: paleGreenColor,
                      fontSize: 34.dp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.dp),

              /// 取消
              GestureDetector(
                onTap: () => Get.back(),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 30.dp),
                  child: Text(
                    "取消",
                    style: TextStyle(
                      fontSize: 34.dp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20.dp,
      runSpacing: 20.dp,
      children: [
        for (int i = 0; i < state.galleryItems.length; i++)
          Stack(
            children: [
              /// 展示的是图片列表
              Visibility(
                visible: state.status == 1,

                /// 点击预览图片
                child: GestureDetector(
                  onTap: () => {
                    Get.to(
                      /// 多图片选择器  自定义widget
                      GalleryPhotoViewWrapper(
                        /// 图片列表
                        galleryItems: state.galleryItems,

                        /// 选择的当前图片下标
                        initialIndex: i,

                        /// 背景修饰器
                        backgroundDecoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  },
                  child: Hero(
                    tag: state.galleryItems[i].id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.dp),

                      /// 图片
                      child: CachedImage(
                        imgUrl: state.galleryItems[i].filePath,
                        width: 210.dp,
                        height: 210.dp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              /// 展示的是视频列表
              Visibility(
                visible: state.status == 2,

                /// 点击预览视频
                child: GestureDetector(
                  onTap: logic.goToVideoPreview,
                  child: Hero(
                    tag: "video",
                    child: Container(
                      width: 210.dp,
                      height: 210.dp,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.dp),
                      ),
                      child: state.video.value.isInitialized

                          /// 视频播放器
                          ? VideoPlayer(
                              state.video,
                            )
                          : Container(),
                    ),
                  ),
                ),
              ),

              /// 删除图标
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => logic.deleteImg(i),
                  child: Image.asset(
                    "img/Icon/delete.png",
                    width: 34.dp,
                    height: 34.dp,
                  ),
                ),
              ),
            ],
          ),

        /// 添加照片  只能添加九张图片
        Visibility(
          visible: state.status == 1 && state.galleryItems.length < 9,
          child: GestureDetector(
            onTap: () => logic.selectImg(),
            child: Container(
              width: 210.dp,
              height: 210.dp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.dp),
                color: blackGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedImage(
                    imgUrl: "${RequestApi.imgBaseUrl}jiahao.png",
                    width: 50.dp,
                    height: 50.dp,
                  ),
                  SizedBox(height: 15.dp),
                  Text(
                    "添加照片",
                    style: TextStyle(
                      fontSize: 22.dp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// 选择添加照片还是视频
        Visibility(
          visible: state.status == 0,
          child: GestureDetector(
            onTap: () => showBottomPopup(context),
            child: Container(
              width: 210.dp,
              height: 210.dp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.dp),
                color: blackGrey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "img/Icon/jiahao.png",
                    width: 50.dp,
                    height: 50.dp,
                  ),
                  SizedBox(height: 15.dp),
                  Text(
                    "添加",
                    style: TextStyle(
                      fontSize: 22.dp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
