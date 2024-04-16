import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/photo_Gallery.dart';

import 'logic.dart';

/// 反馈页面
class Feedback extends StatelessWidget {
  Feedback({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(FeedbackLogic());

  /// 数据层
  final state = Get.find<FeedbackLogic>().state;

  /// 图片展示
  Widget img() {
    return Wrap(
      spacing: 30.dp,
      runSpacing: 20.dp,
      children: [
        for (int i = 0; i < state.galleryItems.length; i++)
          Stack(
            children: [
              GestureDetector(
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
                    borderRadius: BorderRadius.circular(16.dp),

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
          visible: state.galleryItems.length < 3,
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
                  Image.asset(
                    "img/Icon/jiahao.png",
                    width: 43.dp,
                    height: 43.dp,
                  ),
                  SizedBox(height: 20.dp),
                  Text(
                    "图片证据 (选填)",
                    style: TextStyle(
                      fontSize: 22.dp,
                      color: greyColor,
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

  /// 底部按钮
  Widget bottomArea() {
    return GestureDetector(
      onTap: state.phone.characters.length == 11 && state.textContent.isNotEmpty
          ? logic.feedBackSave
          : null,
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dp),
          color: state.phone.characters.length == 11 &&
                  state.textContent.isNotEmpty
              ? paleGreenColor
              : const Color.fromRGBO(48, 55, 56, 1),
        ),
        child: Text(
          "提交",
          style: TextStyle(fontSize: 30.dp, color: Colors.white),
        ),
      ),
    );
  }

  /// 输入框
  Widget input() {
    return TextField(
      /// 是否填充父级
      expands: true,

      /// 填充所需
      maxLines: null,

      /// 填充所需
      minLines: null,

      /// 最大长度
      maxLength: 500,

      textAlignVertical: TextAlignVertical.top,

      /// 控制器
      controller: state.textController,

      /// 监听输入改变的时候
      onChanged: logic.onChanged,

      /// 输入的文本样式
      style: TextStyle(
        color: const Color.fromRGBO(223, 226, 235, 1),
        fontSize: 28.dp,
      ),

      /// 光标颜色
      cursorColor: const Color.fromRGBO(223, 226, 235, 1),

      /// 装饰
      decoration: InputDecoration(
        /// 未输入时提示的内容
        hintText: "请描述您的问题...",

        /// 提示的文本样式
        hintStyle: TextStyle(
          color: greyColor,
          fontSize: 28.dp,
          fontFamily: "PingFang SC",
        ),

        /// 内边距
        contentPadding: EdgeInsets.only(
            left: 25.dp, right: 25.dp, top: 25.dp, bottom: 40.dp),

        /// 计数文本样式
        counterStyle: const TextStyle(color: Colors.transparent),

        /// 是否填充
        filled: true,

        /// 填充的颜色  类似背景颜色
        fillColor: blackGrey,

        /// 边框
        enabledBorder: _getEditBorder(),

        /// 聚焦后的边框
        focusedBorder: _getEditBorder(),
      ),
    );
  }

  /// 联系方式
  Widget contact() {
    return Container(
      height: 96.dp,
      decoration: BoxDecoration(
        color: blackGrey,
        borderRadius: BorderRadius.circular(10.dp),
      ),
      padding: EdgeInsets.only(left: 70.dp),
      child: Row(
        children: [
          Text(
            "联系方式:",
            style: TextStyle(
              fontSize: 30.dp,
              color: greyColor,
            ),
          ),
          SizedBox(width: 40.dp),
          Expanded(
            child: TextField(

              maxLength: 11,

              /// 监听输入改变的时候
              onChanged: logic.changPhone,

              /// 键盘类型
              keyboardType: TextInputType.number,

              /// 输入的文本样式
              style: TextStyle(
                color: greyColor,
                fontSize: 26.dp,
              ),

              /// 光标颜色
              cursorColor: themeWhite,

              /// 装饰
              decoration: InputDecoration(
                /// 未输入时提示的内容
                hintText: "请输入您的手机号~",

                /// 提示的文本样式
                hintStyle: TextStyle(
                  color: darkGreyColor,
                  fontSize: 26.dp,
                  fontFamily: "PingFang SC",
                ),

                counterText: "",

                /// 边框
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取输入框的Border属性，可公用
  OutlineInputBorder _getEditBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.dp)),
      borderSide: BorderSide.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("反馈"),
        actions: [
          /// 历史反馈
          GestureDetector(
            onTap: logic.goToHistoricalFeedback,
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.only(right: 30.dp),
              alignment: Alignment.center,
              child: Text(
                "历史反馈",
                style: TextStyle(
                  fontSize: 30.dp,
                  color: paleGreenColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<FeedbackLogic>(
        builder: (_) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
            children: [
              SizedBox(height: 40.dp),
              Text(
                "问题描述",
                style: TextStyle(
                  fontSize: 36.dp,
                ),
              ),

              SizedBox(height: 30.dp),

              /// 输入框
              Stack(
                children: [
                  /// 输入框
                  SizedBox(
                    height: 360.dp,
                    child: input(),
                  ),

                  /// 最大字数
                  Positioned(
                    bottom: 50.dp,
                    right: 20.dp,
                    child: Text(
                      "500字以内",
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 24.dp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.dp),

              /// 图片区域
              img(),

              SizedBox(height: 100.dp),

              /// 输入联系方式
              contact(),

              SizedBox(height: 30.dp),

              /// 底部按钮
              bottomArea(),

              SizedBox(height: 35.dp),

              Text(
                "注：为了了解详情可能会拨打您的电话请注意接听",
                style: TextStyle(
                  fontSize: 24.dp,
                  color: darkGreyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
