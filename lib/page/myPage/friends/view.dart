import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/Input_box.dart';

import 'logic.dart';

/// 好友页面
class FriendsPage extends StatelessWidget {
  FriendsPage({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(FriendsLogic());

  /// 数据层
  final state = Get.find<FriendsLogic>().state;

  /// 好友列表item部分
  /// index        列表索引
  Widget itemPart(index) {
    return GestureDetector(
      onTap: () => logic.upDateChecked(index),
      child: Container(
        color: const Color.fromRGBO(7, 17, 20, 1),
        height: 140.dp,
        child: Row(
          children: [
            leftWidget(state.friendsList[index]),

            /// 头像
            CircleAvatar(
              radius: 50.dp,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(state.friendsList[index].imageUrl),
            ),
            SizedBox(width: 25.dp),

            /// 好友名称和标签
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 好友名称
                            Text(
                              state.friendsList[index].name,
                              style: TextStyle(
                                fontSize: 30.dp,
                              ),
                            ),
                            SizedBox(height: 10.dp),

                            /// 标签
                            Text(
                              "#家人#  这个人很幽默",
                              style: TextStyle(
                                color: greyColor,
                                fontSize: 24.dp,
                              ),
                            ),
                            SizedBox(height: 20.dp),
                          ],
                        )),

                      /// 赠送按钮
                      bgButton("赠送"),
                      SizedBox(width: 40.dp),
                    ],
                  ),

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

  /// 列表item左边widget
  Widget leftWidget(item) {
    /// 复选框
    return GetBuilder<FriendsLogic>(builder: (e) {
      return Container(
        width: 100.dp,
        padding: EdgeInsets.only(left: 30.dp),
        child: Stack(
          children: [
            Visibility(
              visible: item.isChecked,
              child: Image.asset(
                "img/Icon/check_yes.png",
                width: 40.dp,
                height: 40.dp,
              ),
            ),
            Visibility(
              visible: !item.isChecked,
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

  /// 背景按钮
  Widget bgButton(String title) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 106.dp,
        height: 54.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: paleGreenColor,
          borderRadius: BorderRadius.circular(27.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.dp,
          ),
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
        title: const Text("好友"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.dp),

            /// 输入框 自定义widget
            child: InputBox(
              onTap: () => logic.goToSearchPage(),
              title: "圈达号/手机号/名称",
            ),
          ),
          SizedBox(height: 30.dp),
          for (int i = 0; i < state.friendsList.length; i++) itemPart(i)
        ],
      ),
    );
  }
}
