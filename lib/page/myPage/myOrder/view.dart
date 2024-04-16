import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/TabListPage.dart';

/// 我的订单页面
class MyOrder extends StatelessWidget {
  MyOrder({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MyOrderLogic());

  /// 数据层
  final state = Get.find<MyOrderLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("我的订单"),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Column(
          children: [
            /// tab栏
            TabBar(
              /// 指示器颜色
              indicatorColor: orange,

              /// 指示器大小
              indicatorSize: TabBarIndicatorSize.label,

              /// 指示器宽度
              indicatorWeight: 6.dp,

              /// 指示器padding
              indicatorPadding: EdgeInsets.all(14.dp),

              /// 选定的标签颜色
              labelColor: themeWhite,

              /// 标签的样式
              labelStyle: TextStyle(
                fontSize: 30.dp,
                color: greyColor,
              ),

              /// 未选中的标签颜色
              unselectedLabelColor: greyColor,

              /// 标签的padding
              labelPadding: EdgeInsets.symmetric(horizontal: 18.dp),

              /// 是否滚动
              isScrollable: true,
              padding: EdgeInsets.symmetric(horizontal: 15.dp),
              onTap: (index) {
                print("=====$index");
                if(index != 4) {
                  state.select = index - 1;
                } else {
                  state.select = 4;
                }
              },
              tabs: [
                for (final tab in state.tabs) Tab(text: tab),
              ],
            ),

            /// tabPage页面
            Expanded(
              child: TabBarView(
                /// 不允许滑动
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  TabListPage(
                    data: state,
                    logic: logic,
                    status: -1,
                  ),
                  TabListPage(
                    data: state,
                    logic: logic,
                    status: 0,
                  ),
                  TabListPage(
                    data: state,
                    logic: logic,
                    status: 1,
                  ),
                  TabListPage(
                    data: state,
                    logic: logic,
                    status: 2,
                  ),
                  TabListPage(
                    data: state,
                    logic: logic,
                    status: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
