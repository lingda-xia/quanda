import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/itemBox.dart';

/// 赠礼页面
class Gifts extends StatelessWidget {
  Gifts({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(GiftsLogic());

  /// 数据层
  final state = Get.find<GiftsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          /// 回退键
          leading: const BackButton(),
          title: Container(
            child: TabBar(
              /// 指示器颜色
              indicatorColor: paleGreenColor,

              /// 指示器大小
              indicatorSize: TabBarIndicatorSize.label,

              /// 指示器宽度
              indicatorWeight: 6.dp,

              /// 指示器padding
              indicatorPadding:
                  EdgeInsets.symmetric(horizontal: 20.dp, vertical: 16.dp),

              /// 选定的标签颜色
              labelColor: themeWhite,

              /// 标签的样式
              labelStyle: TextStyle(
                fontSize: 36.dp,
                color: greyColor,
              ),

              /// 未选中标签的颜色
              unselectedLabelColor: greyColor,

              /// 标签的padding
              labelPadding: EdgeInsets.symmetric(horizontal: 20.dp),

              /// 是否滚动
              isScrollable: true,
              tabs: [
                for (final tab in state.tabs) Tab(text: tab),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: [
                /// 列表item
                ItemBox(
                  data: state,
                  onTap: () => {},
                  logic: logic,
                ),
                ItemBox(
                  data: state,
                  onTap: () => {},
                  logic: logic,
                ),
              ],
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
