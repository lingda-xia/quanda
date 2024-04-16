import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 新建标签页面
class NewLabel extends StatelessWidget {
  NewLabel({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(NewLabelLogic());

  /// 数据层
  final state = Get.find<NewLabelLogic>().state;

  /// 通讯录列表头部widget
  Widget fixedHead() {
    return Column(
      children: [
        /// 标签名称
        Container(
          height: 50.dp,
          color: darkBlackDivider,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 40.dp),
          child: Text(
            "标签名称",
            style: TextStyle(
              color: darkGreyColor,
              fontSize: 24.dp,
            ),
          ),
        ),

        /// 标签输入框
        Stack(
          children: [
            /// 输入框
            SizedBox(
              height: 96.dp,
              child: TextField(

                /// 控制器
                controller: state.textController,

                maxLength: 8,

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
                  hintText: "设置标签名称",

                  /// 提示的文本样式
                  hintStyle: TextStyle(
                    color: greyColor,
                    fontSize: 28.dp,
                    fontFamily: "PingFang SC",
                  ),

                  counterText: "",

                  /// 内边距
                  contentPadding: EdgeInsets.symmetric(horizontal: 40.dp),

                  /// 是否填充
                  filled: true,

                  /// 边框
                  border: InputBorder.none,
                ),
              ),
            ),

            /// 关闭按钮
            Positioned(
              right: 40.dp,
              top: 30.dp,
              child: GestureDetector(
                onTap: () => logic.clearInputBox(),
                behavior: HitTestBehavior.translucent,
                child: Image.asset(
                  "img/Icon/chacha.png",
                  width: 35.dp,
                  height: 35.dp,
                ),
              ),
            ),
          ],
        ),

        /// 下划线
        Divider(
          height: 1.dp,
          thickness: 1.dp,
          color: lightBlackDivider,
        ),

        /// 标签成员和添加
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.dp, vertical: 30.dp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 标签成员
              Text(
                "标签成员（${state.friendList.length}）",
                style: TextStyle(
                  color: greyColor,
                  fontSize: 30.dp,
                ),
              ),

              /// 添加成员
              GestureDetector(
                onTap: () => logic.goToAddMember(),
                behavior: HitTestBehavior.translucent,
                child: Row(
                  children: [
                    Image.asset(
                      "img/Icon/add.png",
                      width: 30.dp,
                      height: 30.dp,
                    ),
                    SizedBox(width: 10.dp),
                    Text(
                      "添加成员",
                      style: TextStyle(
                        color: paleGreenColor,
                        fontSize: 30.dp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("新建标签"),
        actions: [
          /// 确定按钮
          GetBuilder<NewLabelLogic>(
            builder: (e) {
              return Visibility(
                visible: state.textContent != "",
                child: GestureDetector(
                  onTap: logic.addLabel,
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    padding: EdgeInsets.only(right: 40.dp),
                    alignment: Alignment.center,
                    child: Text(
                      "确定",
                      style: TextStyle(
                        color: paleGreenColor,
                        fontSize: 30.dp,
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ],
      ),

      body: GetBuilder<NewLabelLogic>(builder: (e) {
        /// 通讯录列表  自定义widget
        return AddressList(
          /// 头部widget
          fixedHead: fixedHead(),

          /// 好友列表
          friendList: state.friendList,

          /// 每一个组头距离顶部的距离
          groupOffsetMap: state.groupOffsetMap,

          /// 好友item点击事件  前往查看好友状态页面
          itemOnTap: (item) => logic.goToViewFriends(item),
        );
      }),
    );
  }
}
