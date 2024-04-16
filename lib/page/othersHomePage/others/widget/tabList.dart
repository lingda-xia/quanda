import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// tab列表
class TabList extends StatelessWidget {
  const TabList({
    Key? key,
    required this.logic,
    required this.state,
  }) : super(key: key);

  /// 数据源
  final OthersState state;

  /// 逻辑层
  final OthersLogic logic;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            indicatorPadding: EdgeInsets.all(16.dp),

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
            padding: EdgeInsets.symmetric(horizontal: 30.dp),
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
                ListPage(
                  type: 0,
                  state: state,
                  logic: logic,
                ),
                ListPage(
                  type: 1,
                  state: state,
                  logic: logic,
                ),
                ListPage(
                  type: 2,
                  state: state,
                  logic: logic,
                ),
                ListPage(
                  type: 3,
                  state: state,
                  logic: logic,
                ),
                ListPage(
                  type: 4,
                  state: state,
                  logic: logic,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 列表页面
class ListPage extends StatefulWidget {
  const ListPage(
      {Key? key, required this.type, required this.logic, required this.state})
      : super(key: key);

  /// 列表类别
  final int type;

  /// 数据源
  final OthersState state;

  /// 逻辑层
  final OthersLogic logic;

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  /// 列表item
  Widget listItem(ReleaseList item) {
    return GestureDetector(
      /// 前往详情页
      onTap: () => widget.logic.goToSeeDetails(item.id.toString()),
      child: Container(
        width: 335.dp,
        height: 500.dp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dp),
          color: blackGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 图片展示
            CachedImage(
              imgUrl:
                  item.mediaList[0].fileVideoPath ?? item.mediaList[0].filePath,
              width: 335.dp,
              height: 340.dp,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.dp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.dp),
              height: 70.dp,
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: 26.dp,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 15.dp),

            /// 标签和点赞
            GetBuilder<OthersLogic>(builder: (e) {
              return Row(
                children: [
                  SizedBox(width: 15.dp),
                  Text(
                    "#${widget.state.tabs[item.type]}#",
                    style: TextStyle(
                      fontSize: 26.dp,
                      color: orange,
                    ),
                  ),
                  const Expanded(child: SizedBox()),

                  /// 爱心点赞
                  GestureDetector(
                    onTap: item.giveStatus == 1
                        ? null
                        : () => widget.logic.giveRelease(item.id, widget.type),
                    child: Container(
                      height: 40.dp,
                      padding: EdgeInsets.only(right: 10.dp, left: 40.dp),
                      child: Image.asset(
                        "img/Icon/${item.giveStatus == 1 ? "love" : "no_love"}.png",
                        width: 22.dp,
                        height: 20.dp,
                      ),
                    ),
                  ),

                  Text(
                    item.giveNumber.toString(),
                    style: TextStyle(
                      fontSize: 22.dp,
                      color: const Color.fromRGBO(153, 153, 153, 1),
                    ),
                  ),

                  SizedBox(width: 15.dp),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<OthersLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (widget.state.reload[widget.type] ?? false) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 页面保活
    super.build(context);

    /// 刷新和加载组件  自定义widget
    return RefreshLoad(
      /// 初始化请求
      init: (page) => widget.logic.getList(widget.type, page),

      /// 用于重置列表
      resetList: (reset) => reload(reset),

      /// 加载为空的提示
      emptyTips: "空空如也~",

      /// 加载为空的图片widget
      emptyWidget: Image.asset(
        "img/bigIcon/empty.png",
        width: 540.dp,
        height: 320.dp,
      ),

      child: GetBuilder<OthersLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 30.dp),
          children: [
            Wrap(
              spacing: 20.dp,
              runSpacing: 20.dp,
              children: [
                for (int i = 0;
                    i < widget.state.listMap[widget.type]!.length;
                    i++)
                  listItem(widget.state.listMap[widget.type]![i])
              ],
            ),
            SizedBox(height: 60.dp),
          ],
        );
      }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
