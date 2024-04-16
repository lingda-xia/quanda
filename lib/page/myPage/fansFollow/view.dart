import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/itemBox.dart';

/// 粉丝关注页面
class FansFollow extends StatelessWidget {
  FansFollow({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(FansFollowLogic());

  /// 数据层
  final state = Get.find<FansFollowLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("粉丝关注"),
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
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
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: 40.dp, vertical: 16.dp),

              /// 选定的标签颜色
              labelColor: paleGreenColor,

              /// 标签的样式
              labelStyle: TextStyle(
                fontSize: 30.dp,
                color: greyColor,
              ),

              /// 未选中标签的颜色
              unselectedLabelColor: greyColor,

              /// 标签的padding
              labelPadding: EdgeInsets.symmetric(horizontal: 80.dp),

              /// 是否滚动
              isScrollable: true,
              tabs: [
                for (final tab in state.tabs) Tab(text: "${tab}(99)"),
              ],
            ),

            /// tabPage页面
            Expanded(
              child: TabBarView(
                /// 不允许滑动
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  /// 列表item
                  TabList(
                    state: state,
                    logic: logic,
                    type: 1,
                  ),
                  TabList(
                    state: state,
                    logic: logic,
                    type: 2,
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
