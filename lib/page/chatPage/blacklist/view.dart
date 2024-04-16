import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:quanda/model/chat/FriendList.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/Input_box.dart';

import 'logic.dart';

/// 黑名单页面
class Blacklist extends StatelessWidget {
  Blacklist({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(BlacklistLogic());

  /// 数据层
  final state = Get.find<BlacklistLogic>().state;

  /// 黑名单列表item部分
  /// index        列表索引
  Widget itemPart(FriendList item, int index) {
    /// 左滑组件
    return Slidable(
      /// 如果不允许滑动，请指定一个键
      key: ValueKey(index),

      /// 结束操作窗格位于右侧或底部。
      endActionPane: ActionPane(
        /// 滚动滑动效果
        motion: const ScrollMotion(),
        children: [
          const SizedBox(width: 90),
          CustomSlidableAction(
            autoClose: true,
            backgroundColor: pink,
            foregroundColor: Colors.white,
            onPressed: (BuildContext context) {
              logic.blackUserAction(item);
            },
            child: Text(
              '删除',
              style: TextStyle(
                fontSize: 30.dp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dp),
        color: const Color.fromRGBO(7, 17, 20, 1),
        height: 140.dp,
        child: Row(
          children: [
            /// 头像
            CircleAvatar(
              radius: 50.dp,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(item.avatarUrl),
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
                    item.remarkName,
                    style: TextStyle(
                      fontSize: 30.dp,
                    ),
                  ),
                  SizedBox(height: 10.dp),

                  /// 标签
                  Text(
                    "${item.name != null ? "#${item.name}#" : ""} ${item.toDesc ?? ""}",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("黑名单"),
      ),
      body: GetBuilder<BlacklistLogic>(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 30.dp),
              //
              //   /// 输入框 自定义widget
              //   child: InputBox(
              //     onTap: () => logic.goToSearchPage(),
              //     title: "圈达号/手机号/名称",
              //   ),
              // ),
              SizedBox(height: 30.dp),

              /// 左滑可取消黑名单
              Container(
                height: 50.dp,
                padding: EdgeInsets.only(left: 40.dp),
                color: darkBlackDivider,
                alignment: Alignment.centerLeft,
                child: Text(
                  "左滑可取消黑名单",
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 24.dp,
                  ),
                ),
              ),

              for (int i = 0; i < state.list.length; i++) itemPart(state.list[i], i)
            ],
          );
        },
      ),
    );
  }
}
