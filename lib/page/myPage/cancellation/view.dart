import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/photo_Gallery.dart';

import 'logic.dart';

/// 注销原因页面
class Cancellation extends StatelessWidget {
  Cancellation({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(CancellationLogic());

  /// 数据层
  final state = Get.find<CancellationLogic>().state;

  /// 底部按钮
  Widget bottomArea() {
    return GestureDetector(
      onTap: state.selectIndex != -1
          ? logic.logoutUser
          : null,
      child: Container(
        height: 96.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dp),
          color: state.selectIndex != -1
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

  /// 原因列表item
  Widget reasonItem(int index) {
    return GetBuilder<CancellationLogic>(builder: (e) {
      /// 选择原因
      return GestureDetector(
        onTap: () => logic.selectReason(index),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.dp),
          child: Row(
            children: [
              /// 单选
              state.selectIndex == index
                  ? Container(
                      width: 30.dp,
                      height: 30.dp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.dp),
                        color: paleGreenColor,
                      ),
                    )
                  : Container(
                      width: 30.dp,
                      height: 30.dp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.dp),
                        color: themeWhite,
                      ),
                    ),

              SizedBox(width: 10.dp),

              /// 原因描述
              Text(
                state.reasonList[index],
                style: TextStyle(
                  fontSize: 30.dp,
                  color: greyColor,
                ),
              ),
            ],
          ),
        ),
      );
    });
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
        hintText: "请详细描述原因，以便我们更好地服务~",

        /// 提示的文本样式
        hintStyle: TextStyle(
          color: greyColor,
          fontSize: 26.dp,
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
        title: const Text("账号注销"),
      ),
      body: GetBuilder<CancellationLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 55.dp),
          children: [
            SizedBox(height: 40.dp),
            Text(
              "选择注销原因",
              style: TextStyle(
                fontSize: 36.dp,
              ),
            ),

            SizedBox(height: 30.dp),

            /// 原因列表
            for (int i = 0; i < state.reasonList.length; i++) reasonItem(i),

            SizedBox(height: 46.dp),

            /// 输入框
            Visibility(
              visible: state.selectIndex == 2,
              child: Stack(
                children: [
                  /// 输入框
                  SizedBox(
                    height: 274.dp,
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
            ),

            SizedBox(height: 10.dp),

            for (int i = 0; i < state.galleryItems.length; i++)
              UnconstrainedBox(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 200.dp,
                  height: 200.dp,
                  child: Stack(
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
                              width: 200.dp,
                              height: 200.dp,
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
                ),
              ),

            /// 选择图片
            Visibility(
              visible: state.galleryItems.isEmpty,
              child: GestureDetector(
                onTap: logic.selectImg,
                behavior: HitTestBehavior.translucent,
                child: UnconstrainedBox(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 200.dp,
                    height: 200.dp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.dp),
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
            ),

            SizedBox(height: 70.dp),

            /// 底部按钮
            bottomArea(),
          ],
        );
      }),
    );
  }
}
