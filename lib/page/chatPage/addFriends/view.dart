import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 添加好友页面
class AddFriends extends StatelessWidget {
  AddFriends({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AddFriendsLogic());

  /// 数据层
  final state = Get.find<AddFriendsLogic>().state;

  /// 输入框
  Widget inputBox() {
    return Container(
      height: 336.dp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.dp),
      ),

      /// 裁剪
      clipBehavior: Clip.hardEdge,
      child: TextField(
        /// 控制器
        controller: state.textController,

        /// 填充满父级元素所需要求
        maxLines: null,

        /// 填充满父级元素所需要求
        minLines: null,

        /// 是否填充满父级元素
        expands: true,

        /// 监听输入改变的时候
        onChanged: logic.onSearch,

        /// 输入的文本样式
        style: TextStyle(
          color: themeWhite,
          fontSize: 28.dp,
        ),

        /// 光标颜色
        cursorColor: themeWhite,

        /// 将确定按钮换为完成
        textInputAction: TextInputAction.done,

        /// 装饰
        decoration: InputDecoration(
          /// 未输入时提示的内容
          hintText: "说点什么吧...",

          /// 提示的文本样式
          hintStyle: TextStyle(
            color: greyColor,
            fontSize: 28.dp,
            fontFamily: "PingFang SC",
          ),

          /// 内边距
          contentPadding: EdgeInsets.all(30.dp),

          /// 是否填充
          filled: true,

          /// 类似背景颜色
          fillColor: blackGrey,

          /// 边框
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("添加好友"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.dp),
        child: Column(
          children: [
            /// 输入框
            inputBox(),

            SizedBox(height: 50.dp),

            /// 发送申请按钮
            SizedBox(
              width: double.infinity,
              height: 96.dp,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(paleGreenColor), //背景颜色
                  side: MaterialStateProperty.all(BorderSide.none), //边框

                  shape: MaterialStateProperty.all(const StadiumBorder(
                      side: BorderSide(
                    //设置 界面效果
                    style: BorderStyle.solid,
                  ))), //圆角弧度
                ),
                onPressed: logic.sendFriendApplication,
                child: Text(
                  "发送申请",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.dp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
