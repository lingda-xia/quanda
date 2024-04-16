import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/earth.dart';
import 'widget/tabList.dart';

///  首页
class Index extends StatelessWidget {
  Index({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(IndexLogic());

  /// 数据层
  final state = Get.find<IndexLogic>().state;

  /// 头部搜索框
  Widget head() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// 搜索框
        GestureDetector(
          onTap: () => logic.goToSearchBox(),
          child: Stack(
            children: [
              /// 搜索框
              CachedImage(
                imgUrl: "${RequestApi.imgBaseUrl}search_box.png",
                width: 547.dp,
                height: 130.dp,
              ),
              Positioned(
                width: 547.dp,
                height: 130.dp,
                child: Row(
                  children: [
                    SizedBox(width: 85.dp),
                    Image.asset(
                      "img/Icon/Q.png",
                      width: 28.dp,
                      height: 30.dp,
                    ),
                    SizedBox(width: 15.dp),
                    Text(
                      "找人找商家找兴趣啊",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(child: SizedBox()),

                    /// 点击扫一扫
                    GestureDetector(
                      onTap: logic.scanQRCode,
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        padding: EdgeInsets.all(30.dp),
                        child: Image.asset(
                          "img/Icon/saoma.png",
                          width: 35.dp,
                          height: 35.dp,
                        ),
                      ),
                    ),

                    SizedBox(width: 58.dp),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// 地址框
        Stack(
          children: [
            /// 地址框
            Image.asset(
              "img/Icon/address_box.png",
              width: 175.dp,
              height: 130.dp,
            ),
            Positioned(
              width: 175.dp,
              height: 130.dp,
              child: GetBuilder<IndexLogic>(builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// 市
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.city,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.dp,
                          ),
                        ),
                        SizedBox(width: 4.dp),
                        Image.asset(
                          "img/Icon/triangle.png",
                          width: 18.dp,
                          height: 15.dp,
                        )
                      ],
                    ),

                    /// 区
                    Text(
                      state.district,
                      style: TextStyle(
                        fontSize: 20.dp,
                      ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 背景图
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: NetworkImage("${RequestApi.imgBaseUrl}index_bg.png"),
          fit: BoxFit.cover,
        )),
        child: DefaultTabController(
          initialIndex: 0,
          length: 5,
          child: SafeArea(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                      children: [
                        /// 头部搜索框
                        head(),

                        /// 地球动画 自定义widget
                        Earth(
                          onTap: (int data) {},
                          data: state,
                        ),

                        /// tab
                        SizedBox(
                          height: 100.dp,
                          child: GetBuilder<IndexLogic>(
                            builder: (_) {
                              return TabBar(
                                /// 激活后的文本颜色
                                labelColor: paleGreenColor,

                                /// 激活后的文本样式
                                labelStyle: TextStyle(
                                  fontSize: 26.dp,
                                  fontFamily: "PingFang SC",
                                ),

                                /// 未激活的文本样式
                                unselectedLabelStyle: TextStyle(
                                  fontSize: 26.dp,
                                  fontFamily: "PingFang SC",
                                ),

                                /// 标签的padding
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 30.dp),

                                /// 未激活的颜色
                                unselectedLabelColor: themeWhite,

                                /// 是否滚动
                                isScrollable: true,

                                /// 指示器装饰
                                indicator: const BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                onTap: logic.setIndex,
                                tabs: [
                                  for (int i = 0; i < state.tabList.length; i++)
                                    Container(
                                      width: 82.dp,
                                      height: 58.dp,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "img/Icon/${state.index == i ? "tab_box" : "tab_box_no"}.png")),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        state.tabList[i],
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),

                        /// tab列表
                        SizedBox(
                          height: Get.height - 200.dp,
                          child: TabBarView(
                            /// 不允许滑动
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              /// 列表  自定义widget
                              TabList(
                                state: state,
                                getLogic: logic,
                                type: 0,
                              ),
                              TabList(
                                state: state,
                                getLogic: logic,
                                type: 1,
                              ),
                              TabList(
                                state: state,
                                getLogic: logic,
                                type: 2,
                              ),
                              TabList(
                                state: state,
                                getLogic: logic,
                                type: 3,
                              ),
                              TabList(
                                state: state,
                                getLogic: logic,
                                type: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
