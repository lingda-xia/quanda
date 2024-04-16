import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/function_event.dart';
import 'package:quanda/widget/user_status_bar.dart';

import 'logic.dart';

/// 加好友验证页面
class FriendVerification extends StatelessWidget {
  FriendVerification({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(FriendVerificationLogic());

  /// 数据层
  final state = Get.find<FriendVerificationLogic>().state;

  /// 验证信息
  Widget information(BuildContext context) {
    return Container(
      height: 220.dp,
      margin: EdgeInsets.only(left: 30.dp, right: 30.dp, bottom: 30.dp),
      padding: EdgeInsets.symmetric(horizontal: 30.dp, vertical: 25.dp),
      decoration: BoxDecoration(
        color: validationColor,
        borderRadius: BorderRadius.circular(10.dp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            /// 聊天框
            child: GetBuilder<FriendVerificationLogic>(builder: (_){
              return ListView(
                children: [
                  /// 聊天内容
                  for(int i = 0; i < state.othersInfo.checkMessageList.length; i++)
                    Row(
                      children: [
                        /// 名字
                        Text(
                          "${state.othersInfo.checkMessageList[i].name}：",
                          style: TextStyle(
                            fontSize: 26.dp,
                          ),
                        ),
                        /// 内容
                        Text(
                          state.othersInfo.checkMessageList[i].content,
                          style: TextStyle(
                            fontSize: 26.dp,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            }),

          ),

          /// 输入框
          GetBuilder<FriendVerificationLogic>(builder: (_){
            return SizedBox(
              height: state.focus,
              child: TextField(

                /// 控制器
                controller: state.textController,

                maxLines: 1,

                /// 焦点控制
                focusNode: state.focusNode,

                /// 输入完成时
                onEditingComplete: logic.onEditingComplete,

                /// 输入的文本样式
                style: TextStyle(
                  color: const Color.fromRGBO(223, 226, 235, 1),
                  fontSize: 26.dp,
                ),

                /// 光标颜色
                cursorColor: const Color.fromRGBO(223, 226, 235, 1),

                /// 将确定按钮换为发送
                textInputAction: TextInputAction.send,

                /// 装饰
                decoration: InputDecoration(

                  /// 内边距
                  contentPadding: EdgeInsets.symmetric(horizontal: 0.dp, vertical: 28.dp),

                  /// 边框
                  border: InputBorder.none,

                ),
              ),
            );
          }),

          /// 回复
          GestureDetector(
            onTap: () => logic.reply(context),
            behavior: HitTestBehavior.translucent,
            child: Text(
              "回复",
              style: TextStyle(
                color: paleGreenColor,
                fontSize: 28.dp,
              ),
            ),
          ),
        ],
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("加好友验证"),
      ),
      body: Column(
        children: [
          /// 用户信息状态栏  自定义widget
          GetBuilder<FriendVerificationLogic>(builder: (_){
            return UserStatusBar(
              data: state.othersInfo,
            );
          }),

          /// 验证信息
          information(context),

          /// 下划线
          Divider(
            height: 10.dp,
            thickness: 10.dp,
            color: darkBlackDivider,
          ),

          /// 查看就显示  等待验证就不显示
          Visibility(
            visible: state.type == "1" ? true : false,
            child: Column(
              children: [
                /// 来源
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 25.dp),
                  child: Row(
                    children: [
                      Text(
                        "来源:",
                        style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 26.dp,
                        ),
                      ),
                      SizedBox(width: 20.dp),

                      GetBuilder<FriendVerificationLogic>(builder: (_){
                        return Text(
                          state.othersInfo.source,
                          style: TextStyle(
                            color: darkGreyColor,
                            fontSize: 26.dp,
                          ),
                        );
                      }),

                    ],
                  ),
                ),
                /// 下划线
                Divider(
                  height: 10.dp,
                  thickness: 10.dp,
                  color: darkBlackDivider,
                ),

                /// 前往验证
                FunctionEvent(
                  onTap: () {
                    /// 前往通过验证页
                    logic.goToPassValidation();
                  },
                  title: "前往验证",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
