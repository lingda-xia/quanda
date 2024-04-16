import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:quanda/widget/function_event.dart';
import 'package:quanda/widget/user_status_bar.dart';

import 'logic.dart';

/// 查看好友状态页面
class ViewFriends extends StatelessWidget {
  ViewFriends({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(ViewFriendLogic());

  /// 数据层
  final state = Get.find<ViewFriendLogic>().state;

  /// 个人主页
  Widget personalHomepage() {
    return Column(
      children: [
        GestureDetector(
          onTap: logic.goToOthers,
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 20.dp),
            child: Row(
              children: [
                /// 标签
                Text(
                  "个人主页",
                  style: TextStyle(
                    fontSize: 28.dp,
                  ),
                ),

                SizedBox(width: 50.dp),

                /// 信息说明
                Expanded(
                  child: Wrap(
                    spacing: 30.dp,
                    children: [
                      for (int i = 0;
                          i < state.othersInfo.momentList.length;
                          i++)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60.dp),
                          child: CachedImage(
                            imgUrl: state.othersInfo.momentList[i],
                            width: 118.dp,
                            height: 118.dp,
                          ),
                        )
                    ],
                  ),
                ),

                /// 右箭头
                Icon(
                  Icons.chevron_right,
                  color: greyColor,
                  size: 40.dp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 输入内容
  Widget inputContent({
    required AParameterCallback<String> onChange,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String tips,
  }) {
    return TextField(
      minLines: 1,

      maxLength: 8,

      focusNode: focusNode,

      controller: controller,

      /// 监听输入改变的时候
      onChanged: onChange,

      /// 输入的文本样式
      style: TextStyle(
        color: greyColor,
        fontSize: 28.dp,
      ),

      /// 光标颜色
      cursorColor: themeWhite,

      /// 装饰
      decoration: InputDecoration(
        /// 未输入时提示的内容
        hintText: tips,

        counterText: "",

        /// 提示的文本样式
        hintStyle: TextStyle(
          color: greyColor,
          fontSize: 28.dp,
          fontFamily: "PingFang SC",
        ),

        /// 边框
        border: InputBorder.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// 如果改动过备注和描述
        if (state.modify) {
          /// 修改好友描述和备注
          await logic.friendEditBy();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<ViewFriendLogic>(builder: (_) {
                /// 用户信息状态栏  自定义widget
                return UserStatusBar(
                  data: state.othersInfo,
                );
              }),

              /// 下划线
              Divider(
                height: 10.dp,
                thickness: 10.dp,
                color: darkBlackDivider,
              ),

              GetBuilder<ViewFriendLogic>(builder: (_) {
                /// 状态栏
                return Column(
                  children: [
                    /// 备注
                    Column(
                      children: [
                        Container(
                          height: 96.dp,
                          padding: EdgeInsets.symmetric(horizontal: 40.dp),
                          child: Row(
                            children: [
                              /// 标签
                              Text(
                                "备注",
                                style: TextStyle(
                                  fontSize: 28.dp,
                                ),
                              ),

                              SizedBox(width: 25.dp),

                              /// 信息说明
                              Expanded(
                                child: inputContent(
                                  onChange: logic.remarksChange,
                                  controller: state.bController,
                                  focusNode: state.bFocusNode,
                                  tips: "备注个什么呢~",
                                ),
                              ),

                              /// 右箭头
                              Icon(
                                Icons.chevron_right,
                                color: greyColor,
                                size: 40.dp,
                              ),
                            ],
                          ),
                        ),

                        /// 下划线
                        Divider(
                          height: 1.dp,
                          thickness: 1.dp,
                          color: lightBlackDivider,
                        ),
                      ],
                    ),

                    /// 标签
                    Column(
                      children: [
                        GestureDetector(
                          onTap: logic.goToSelectLabel,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            height: 96.dp,
                            padding: EdgeInsets.symmetric(horizontal: 40.dp),
                            child: Row(
                              children: [
                                /// 标签
                                Text(
                                  "标签",
                                  style: TextStyle(
                                    fontSize: 28.dp,
                                  ),
                                ),
                                SizedBox(width: 25.dp),

                                /// 信息说明
                                Expanded(
                                  child: Text(
                                    state.othersInfo.tagName.isNotEmpty
                                        ? state.othersInfo.tagName
                                        : "暂无标签",
                                    style: TextStyle(
                                      color: greyColor,
                                      fontSize: 28.dp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),

                                /// 右箭头
                                Icon(
                                  Icons.chevron_right,
                                  color: greyColor,
                                  size: 40.dp,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// 下划线
                        Divider(
                          height: 1.dp,
                          thickness: 1.dp,
                          color: lightBlackDivider,
                        ),
                      ],
                    ),

                    /// 描述
                    Column(
                      children: [
                        Container(
                          height: 96.dp,
                          padding: EdgeInsets.symmetric(horizontal: 40.dp),
                          child: Row(
                            children: [
                              /// 标签
                              Text(
                                "描述",
                                style: TextStyle(
                                  fontSize: 28.dp,
                                ),
                              ),
                              SizedBox(width: 25.dp),

                              /// 输入框
                              Expanded(
                                child: inputContent(
                                  onChange: logic.describeChange,
                                  controller: state.mController,
                                  focusNode: state.mFocusNode,
                                  tips: "描述一下好友~",
                                ),
                              ),

                              /// 右箭头
                              Icon(
                                Icons.chevron_right,
                                color: greyColor,
                                size: 40.dp,
                              ),
                            ],
                          ),
                        ),

                        /// 下划线
                        Divider(
                          height: 1.dp,
                          thickness: 1.dp,
                          color: lightBlackDivider,
                        ),
                      ],
                    ),

                    /// 简介
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.dp, vertical: 30.dp),
                          child: Row(
                            children: [
                              /// 标签
                              Text(
                                "简介",
                                style: TextStyle(
                                  fontSize: 28.dp,
                                ),
                              ),
                              SizedBox(width: 25.dp),

                              /// 信息说明
                              Expanded(
                                child: Text(
                                  state.othersInfo.introduction,
                                  style: TextStyle(
                                    color: greyColor,
                                    fontSize: 28.dp,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  // maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// 下划线
                        Divider(
                          height: 1.dp,
                          thickness: 1.dp,
                          color: lightBlackDivider,
                        ),
                      ],
                    ),

                    /// 个人主页
                    personalHomepage(),
                  ],
                );
              }),

              /// 下划线
              Divider(
                height: 10.dp,
                thickness: 10.dp,
                color: darkBlackDivider,
              ),

              /// 发消息
              FunctionEvent(
                onTap: logic.goToPrivateChat,
                title: "发消息",
              ),

              /// 加入黑名单
              FunctionEvent(
                onTap: logic.blackmailUsers,
                title: "加入黑名单",
              ),

              // /// 投诉
              // FunctionEvent(
              //   onTap: logic.goToComplaint,
              //   title: "投诉",
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
