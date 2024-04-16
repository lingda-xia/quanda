import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'state.dart';
import 'widget/imgOrVideo.dart';

/// 发布公用部分 页面
class PublishPublic extends StatelessWidget {
  PublishPublic({
    Key? key,
    required this.children,
    required this.release,
    required this.saveDraft,
    required this.initDialog,
    required this.setContent,
  }) : super(key: key);

  /// 发布 三个参数
  /// 地址名称    经纬度    图片id列表
  final FiveParameterCallback release;

  /// 保存草稿 六个个参数
  /// 地址名称    经纬度    图片列表
  final SixParameterCallback saveDraft;

  /// 使用草稿时为父组件设置参数
  final AParameterCallback setContent;

  /// 是否可以打开使用草稿对话框
  final NoParameterCallback initDialog;

  /// 需要渲染的长children
  final List<Widget> children;

  /// 逻辑层
  final logic = Get.put(PublishPublicLogic());

  /// 数据层
  final state = Get.find<PublishPublicLogic>().state;

  /// 发布按钮
  Widget publishButton() {
    return GestureDetector(
      onTap: () {
        state.focusNode.unfocus;
        state.cFocusNode.unfocus;
        /// 发布事件
        release(state.title, state.content, state.displayedLocation,
            state.positional, state.idList);
      },
      child: Container(
        width: 112.dp,
        height: 58.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: paleGreenColor,
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          "发布",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  /// 保存草稿
  Widget keepDraft() {
    return GestureDetector(
      onTap: () {
        state.saved = true;
        saveDraft(state.title, state.content,
            state.displayedLocation, state.positional, state.galleryItems, state.status);
      } ,
      child: Container(
        width: 112.dp,
        height: 58.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(29.dp),
            border: Border.all(
              width: 2.dp,
              color: paleGreenColor,
            )),
        child: Text(
          "存草稿",
          style: TextStyle(
            color: paleGreenColor,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  /// 标题输入框
  Widget titleInput() {
    return SizedBox(
      height: 100.dp,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              minLines: 1,

              maxLength: 30,

              controller: state.titleController,

              focusNode: state.focusNode,

              /// 监听输入改变的时候
              onChanged: logic.titleChange,

              /// 输入的文本样式
              style: TextStyle(
                color: themeWhite,
                fontSize: 30.dp,
              ),

              /// 光标颜色
              cursorColor: themeWhite,

              /// 装饰
              decoration: InputDecoration(
                /// 未输入时提示的内容
                hintText: "输入标题 可吸引更多人看哦~",
                counterText: "",

                /// 提示的文本样式
                hintStyle: TextStyle(
                  color: themeWhite,
                  fontSize: 30.dp,
                  fontFamily: "PingFang SC",
                ),

                /// 边框
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 20.dp),
          Text(
            "30字",
            style: TextStyle(
              fontSize: 24.dp,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }

  /// 内容输入框
  Widget contentInput() {
    return SizedBox(
      height: 350.dp,
      child: TextField(
        minLines: null,

        maxLines: null,

        maxLength: 500,

        focusNode: state.cFocusNode,

        controller: state.contentController,

        /// 是否填充父级
        expands: true,

        /// 监听输入改变的时候
        onChanged: logic.contentChange,

        /// 输入的文本样式
        style: TextStyle(
          color: themeWhite,
          fontSize: 28.dp,
        ),

        /// 光标颜色
        cursorColor: themeWhite,

        /// 装饰
        decoration: InputDecoration(
          /// 未输入时提示的内容
          hintText: "发布什么内容呢...",

          // counterText: "",

          counterStyle: TextStyle(
            color: greyColor,
            fontSize: 26.dp,
          ),

          /// 提示的文本样式
          hintStyle: TextStyle(
            color: greyColor,
            fontSize: 28.dp,
            fontFamily: "PingFang SC",
          ),

          /// 边框
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// 你的位置
  Widget site(BuildContext context) {
    return GestureDetector(
      onTap: () => logic.goToSelectAddress(),
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                "img/Icon/site.png",
                width: 20.dp,
                height: 26.dp,
              ),
              SizedBox(width: 8.dp),
              Text(
                "你的位置",
                style: TextStyle(
                  color: greyColor,
                  fontSize: 26.dp,
                ),
              ),
              const Expanded(child: SizedBox()),

              /// 定位到的地址
              GetBuilder<PublishPublicLogic>(builder: (e) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 480.dp,
                  ),
                  child: Text(
                    state.displayedLocation,
                    style: TextStyle(
                      color: darkGreyColor,
                      fontSize: 26.dp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }),

              SizedBox(width: 15.dp),
              Image.asset(
                "img/Icon/right.png",
                width: 14.dp,
                height: 24.dp,
              ),
            ],
          ),
          SizedBox(height: 25.dp),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// 回调是否可以退出页面
      onWillPop: () async {
        bool value = logic.dataFiltering();

        if (!value && !state.saved) {
          /// 打开提示
          await logic.openDialog(
            () => saveDraft(state.title, state.content, state.displayedLocation,
                state.positional, state.galleryItems, state.status),
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          actions: [
            Row(
              children: [
                /// 存草稿
                keepDraft(),
                SizedBox(width: 30.dp),

                /// 发布按钮
                publishButton(),
                SizedBox(width: 40.dp),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 40.dp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 用于初始化
                GetBuilder<PublishPublicLogic>(initState: (_) async {
                  var value = await initDialog();
                  if (value != null) {
                    /// 草稿
                    logic.applyDraft(value, setContent);
                  }
                  print("这是触发了$value");
                }, builder: (_) {
                  return Container();
                }),

                /// 标题输入框
                titleInput(),

                /// 下划线
                Divider(
                  height: 1.dp,
                  thickness: 1.dp,
                  color: const Color.fromRGBO(32, 37, 36, 1),
                ),

                /// 内容输入框
                contentInput(),

                SizedBox(height: 30.dp),

                /// 图片或者视频区域
                GetBuilder<PublishPublicLogic>(builder: (e) {
                  return ImgOrVideo(
                    state: state,
                    logic: logic,
                  );
                }),

                SizedBox(height: 50.dp),

                /// 你的位置
                site(context),

                /// 下划线
                Divider(
                  height: 1.dp,
                  thickness: 1.dp,
                  color: const Color.fromRGBO(32, 37, 36, 1),
                ),

                /// 渲染的children
                for (int i = 0; i < children.length; i++) children[i],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
