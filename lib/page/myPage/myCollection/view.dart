import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/TabListPage.dart';

/// 我的收藏页面
class MyCollection extends StatelessWidget {
  MyCollection({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(MyCollectionLogic());

  /// 数据层
  final state = Get.find<MyCollectionLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("我的收藏"),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 5,
        child: Column(
          children: [
            /// tab栏
            TabBar(
              /// 指示器颜色
              indicatorColor: paleGreenColor,
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
              padding: EdgeInsets.symmetric(horizontal: 60.dp),
              tabs: [
                for (final tab in state.tabs) Tab(text: tab),
              ],
            ),

            SizedBox(height: 20.dp),

            /// tabPage页面
            Expanded(
              child: TabBarView(
                /// 不允许滑动
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  TabListPage(
                    data: state,
                    type: 0,
                    logic: logic,
                  ),
                  TabListPage(
                    data: state,
                    type: 1,
                    logic: logic,
                  ),
                  TabListPage(
                    data: state,
                    type: 2,
                    logic: logic,
                  ),
                  TabListPage(
                    data: state,
                    type: 3,
                    logic: logic,
                  ),
                  TabListPage(
                    data: state,
                    type: 4,
                    logic: logic,
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
