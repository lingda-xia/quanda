import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'widget/tabList.dart';
import 'widget/userList.dart';

///  首页 搜索框
class SearchBox extends StatelessWidget {
  SearchBox({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SearchBoxLogic());

  /// 数据层
  final state = Get.find<SearchBoxLogic>().state;

  /// 头部搜索框
  Widget head() {
    return Stack(
      children: [
        /// 搜索框
        Image.asset(
          "img/Icon/long_search.png",
          width: Get.width,
          height: 140.dp,
        ),
        Positioned(
          width: Get.width,
          height: 140.dp,
          child: Row(
            children: [
              SizedBox(width: 85.dp),
              Image.asset(
                "img/Icon/Q.png",
                width: 28.dp,
                height: 30.dp,
              ),
              SizedBox(width: 15.dp),
              SizedBox(
                width: 550.dp,
                height: 100.dp,
                // padding: EdgeInsets.only(bottom: 10.dp),
                child: TextField(
                  /// 控制器
                  controller: state.textController,

                  /// 最大行数
                  maxLines: 1,

                  focusNode: state.focusNode,

                  /// 监听输入改变的时候
                  onChanged: logic.onChanged,

                  /// 输入的文本样式
                  style: TextStyle(
                    color: const Color.fromRGBO(223, 226, 235, 1),
                    fontSize: 24.dp,
                  ),

                  /// 光标颜色
                  cursorColor: const Color.fromRGBO(223, 226, 235, 1),

                  /// 将确定按钮换为搜索
                  textInputAction: TextInputAction.search,

                  /// 装饰
                  decoration: InputDecoration(
                    /// 未输入时提示的内容
                    hintText: "找人找商家找兴趣啊",

                    /// 提示的文本样式
                    hintStyle: TextStyle(
                      color: const Color.fromRGBO(118, 122, 134, 1),
                      fontSize: 24.dp,
                      fontFamily: "PingFang SC",
                    ),

                    /// 边框
                    border: InputBorder.none,
                  ),
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
    /// 背景图
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage("${RequestApi.imgBaseUrl}index_bg.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: GetBuilder<SearchBoxLogic>(
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 头部搜索框
                    head(),

                    /// tab
                    state.allow
                        ? SizedBox(
                            height: 100.dp,
                            child: GetBuilder<SearchBoxLogic>(
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
                                    for (int i = 0;
                                        i < state.tabList.length;
                                        i++)
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
                          )
                        : Container(),

                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          state.allow
                              ? TabBarView(
                                  /// 不允许滑动
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    /// 列表  自定义widget
                                    UserList(
                                      state: state,
                                      logic: logic,
                                      type: 0,
                                    ),
                                    TabList(
                                      state: state,
                                      logic: logic,
                                      type: 1,
                                    ),
                                  ],
                                )
                              : Container(),

                          /// 关闭图标
                          Positioned(
                            bottom: 60.dp,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(
                                "img/Icon/publishClose.png",
                                width: 98.dp,
                                height: 98.dp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
