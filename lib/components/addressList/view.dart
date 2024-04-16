import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import 'logic.dart';
import 'widget/indexBar.dart';

/// 通讯录列表
class AddressList extends StatelessWidget {
  AddressList({
    Key? key,
    this.headWidget,
    this.leftWidget,
    this.fixedHead,
    required this.friendList,
    required this.groupOffsetMap,
    required this.itemOnTap,
  }) : super(key: key);

  /// 好友列表
  final List<FriendList?> friendList;

  /// 好友item点击事件
  final AParameterCallback<FriendList> itemOnTap;

  /// 每一个组头距离顶部的距离
  final Map groupOffsetMap;

  /// 头部widget
  final Widget? headWidget;

  /// 固定的头部widget 不参与滚动
  final Widget? fixedHead;

  /// 列表item左边widget
  final Function? leftWidget;

  /// 逻辑层
  final logic = Get.put(AddressListLogic());

  /// 数据层
  final state = Get.find<AddressListLogic>().state;

  /// 组头部分
  /// isShow 是否显示组名
  /// friendList[index].indexLetter    组头名称
  Widget groupHead(bool isShow, String indexLetter) {
    /// 是否显示组头
    return Visibility(
      visible: !isShow,

      /// 组头
      child: Container(
        alignment: Alignment.centerLeft, //靠左边居中
        height: 50.dp,
        color: darkBlackDivider,
        padding: EdgeInsets.only(left: 60.dp),
        child: Text(
          indexLetter,
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 28.dp,
          ),
        ),
      ),
    );
  }

  /// 好友item部分
  /// friendItem   好友信息
  /// index        列表索引
  Widget itemPart(FriendList? friendItem, int index) {
    return GestureDetector(
      /// 前往查看好友状态页面
      onTap: () => itemOnTap(friendItem!),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dp),
        color: const Color.fromRGBO(7, 17, 20, 1),
        height: 140.dp,
        child: Row(
          children: [
            /// 列表item左边widget
            leftWidget == null ? Container() : leftWidget!(friendItem),

            // leftWidget() ?? Container(),
            /// 头像
            CircleAvatar(
              radius: 50.dp,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(friendItem!.avatarUrl == ""
                  ? "${RequestApi.baseUrl}/api/static/boy.png"
                  : friendItem.avatarUrl),
            ),

            SizedBox(width: 25.dp),

            /// 好友名称和标签
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// 好友名称
                  Text(
                    friendItem.remarkName,
                    style: TextStyle(
                      fontSize: 30.dp,
                    ),
                  ),
                  SizedBox(height: 10.dp),

                  /// 标签
                  Text(
                    "${friendItem.name != null ? "#${friendItem.name}#" : ""}  ${friendItem.toDesc ?? ""}",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 24.dp,
                    ),
                  ),
                  SizedBox(height: 20.dp),

                  /// 下划线
                  Divider(
                    height: 1.dp,
                    color: lightBlackDivider,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 通讯录列表渲染
  Widget itemBuilder(int index) {
    /// 是否显示组名  当前item的组名是否跟上一个item的组名相同  相同就不显示组名
    bool isShow = index > 0 &&
        friendList[index]!.indexLetter == friendList[index - 1]!.indexLetter;

    /// 好友列表item 自定义widget
    return Column(
      children: [
        /// 组头部分
        /// isShow 是否显示组名
        /// friendList[index].indexLetter    组头名称
        groupHead(isShow, friendList[index]!.indexLetter),

        /// 好友列表item
        /// friendItem   好友信息
        itemPart(friendList[index], index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 固定头部
        fixedHead ?? Container(),
        Expanded(
          child: Stack(
            children: [
              /// 页面列表
              ListView(
                /// 滚动控制器
                controller: state.scrollController,
                children: [
                  /// 头部widget
                  headWidget ?? Container(),

                  /// 好友列表
                  for (int i = 0; i < friendList.length; i++) itemBuilder(i)
                ],
              ),

              /// 好友列表的索引栏
              IndexBar(
                /// 滑动回调函数
                indexBarCallBack: (String str) {
                  if (groupOffsetMap[str] != null) {
                    state.scrollController.animateTo(groupOffsetMap[str],
                        duration: const Duration(microseconds: 100),
                        curve: Curves.easeIn);
                  }
                },

                /// 数据源
                data: state,

                /// 垂直向下拖拽时回调
                updateData: (index) => logic.updateData(index),

                /// 垂直向下拖拽结束回调
                endUpdate: () => logic.endUpdate(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
