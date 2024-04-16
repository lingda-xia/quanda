import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/addressList/view.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';

/// 添加成员页面
class AddMember extends StatelessWidget {
  AddMember({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(AddMemberLogic());

  /// 数据层
  final state = Get.find<AddMemberLogic>().state;

  /// 已添加的好友头像
  Widget itemBuilder(int index, Animation<double> animation) {
    /// 头像
    return FadeTransition(
      //动画构建
      opacity: animation,
      //子UI
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.dp),
        child: CircleAvatar(
          radius: 50.dp,

          /// 为加载成功时显示的背景色
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(state.selected[index].avatarUrl),
        ),
      ),
    );
  }

  /// 通讯录列表固定头部widget
  Widget fixedHead() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 120.dp,
          color: darkBlackDivider,
          child: Row(
            children: [
              SizedBox(width: 30.dp),

              /// 已添加好友列表
              GetBuilder<AddMemberLogic>(builder: (e) {
                return Container(
                  constraints: BoxConstraints(
                    minWidth: 0.dp,

                    /// 根据已添加的好友数量进行限制
                    maxWidth: state.selected.length > 3
                        ? 360.dp
                        : state.selected.length * 120.dp,
                  ),
                  child: AnimatedList(
                    key: state.globalKey,
                    itemBuilder: (BuildContext context, int index,
                            Animation<double> animation) =>
                        itemBuilder(index, animation),
                    scrollDirection: Axis.horizontal,
                    initialItemCount: state.selected.length,
                    controller: state.scrollController,
                  ),
                );
              }),

              // GetBuilder<AddMemberLogic>(builder: (e) {
              //   return Container(
              //     constraints: BoxConstraints(
              //       minWidth: 100.dp,
              //
              //       /// 根据已添加的好友数量进行限制
              //       maxWidth: state.selected.length > 3
              //           ? 360.dp
              //           : state.selected.length * 120.dp,
              //     ),
              //     child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: itemBuilder,
              //       itemCount: state.selected.length,
              //       controller: state.scrollController,
              //     ),
              //   );
              // }),

              /// 输入框
              Expanded(
                child: TextField(
                  /// 控制器
                  controller: state.textController,

                  /// 最大行数
                  maxLines: 1,

                  /// 监听输入改变的时候
                  onChanged: logic.onSearch,

                  /// 当按下搜索键时触发
                  onEditingComplete: logic.init,

                  /// 输入的文本样式
                  style: TextStyle(
                    color: themeWhite,
                    fontSize: 30.dp,
                  ),

                  /// 光标颜色
                  cursorColor: themeWhite,

                  /// 将确定按钮换为搜索
                  textInputAction: TextInputAction.search,

                  /// 装饰
                  decoration: InputDecoration(
                    /// 未输入时提示的内容
                    hintText: "搜索",

                    /// 提示的文本样式
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontSize: 28.dp,
                      fontFamily: "PingFang SC",
                    ),

                    /// 内边距
                    contentPadding: EdgeInsets.symmetric(horizontal: 40.dp),

                    /// 边框
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 30.dp),
      ],
    );
  }

  /// 列表item左边widget
  Widget leftWidget(FriendList item) {
    /// 复选框
    return GetBuilder<AddMemberLogic>(builder: (e) {
      return Container(
        width: 100.dp,
        padding: EdgeInsets.only(left: 30.dp),
        child: Stack(
          children: [
            Visibility(
              visible: logic.contain(item),
              child: Image.asset(
                "img/Icon/check_yes.png",
                width: 40.dp,
                height: 40.dp,
              ),
            ),
            Visibility(
              visible: !logic.contain(item),
              child: Image.asset(
                "img/Icon/check_no.png",
                width: 40.dp,
                height: 40.dp,
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("添加成员"),
        actions: [
          /// 完成按钮
          GetBuilder<AddMemberLogic>(builder: (e) {
            return GestureDetector(
              onTap: logic.complete,
              child: Container(
                padding: EdgeInsets.only(right: 40.dp),
                alignment: Alignment.center,
                child: Text(
                  "完成",
                  style: TextStyle(
                    color: paleGreenColor,
                    fontSize: 30.dp,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: GetBuilder<AddMemberLogic>(builder: (e) {
        // return Container();
        /// 通讯录列表  自定义widget
        return AddressList(
          /// 头部widget
          fixedHead: fixedHead(),

          /// 列表item左边widget
          leftWidget: (item) => leftWidget(item),

          /// 好友列表
          friendList: state.friendList,

          /// 每一个组头距离顶部的距离
          groupOffsetMap: state.groupOffsetMap,

          /// 好友item点击事件  更新复选框的值
          itemOnTap: (item) => logic.upDateChecked(item, itemBuilder),
        );
      }),
    );
  }
}
