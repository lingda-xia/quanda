import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/index/IndexSearch.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import '../logic.dart';
import '../state.dart';

/// 首页搜索的 tab列表
class TabList extends StatefulWidget {
  const TabList(
      {Key? key, required this.state, required this.logic, required this.type})
      : super(key: key);

  /// 逻辑层
  final SearchBoxLogic logic;

  /// 数据层
  final SearchBoxState state;

  /// 列表的类型
  final int type;

  @override
  State<TabList> createState() => _TabListState();
}

/// 页面保活  AutomaticKeepAliveClientMixin
class _TabListState extends State<TabList> with AutomaticKeepAliveClientMixin {
  /// 列表的item
  Widget item(IndexSearch item) {
    /// 头像
    String avatarUrl = "";

    /// 名称
    String nickname = "";

    if (item.userInfo.isNotEmpty) {
      List<String> list = item.userInfo.split(",");
      avatarUrl = list[0].split("=")[1];

      String str = list[1].split("=")[1];

      nickname = str.substring(0, str.length - 1);

    }

    return GestureDetector(
      /// 前往详情页
      onTap: () => widget.logic.goToSeeDetails(item.id.toString()),
      child: Container(
        height: 238.dp,
        padding: EdgeInsets.symmetric(horizontal: 25.dp),
        margin: EdgeInsets.only(bottom: 30.dp),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("img/Icon/item_bg.png"),
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            /// 媒体展示
            Container(
              width: 170.dp,
              height: 170.dp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.dp),
                color: const Color.fromRGBO(43, 51, 53, 1),
              ),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.dp),

                /// 如果有视频封面则展示视频封面
                child: CachedImage(
                  imgUrl: item.videoImg ?? item.mainImgUrl,
                  width: 150.dp,
                  height: 150.dp,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 20.dp),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 标题
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 26.dp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.dp),

                  /// 标签
                  Text(
                    "#${widget.state.typeList[int.parse(item.type)]}#",
                    style: TextStyle(
                      fontSize: 26.dp,
                      color: paleGreenColor,
                    ),
                  ),

                  SizedBox(height: 20.dp),

                  /// 头像名称等信息
                  Row(
                    children: [
                      /// 前往他人主页
                      GestureDetector(
                        // onTap: () =>
                        //     widget.logic.goToOthers(item.id.toString()),

                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            /// 头像
                            CircleAvatar(
                              radius: 20.dp,

                              /// 为加载成功时显示的背景色
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                avatarUrl == ""
                                    ? "${RequestApi.baseUrl}/api/static/boy.png"
                                    : avatarUrl,
                              ),
                            ),
                            SizedBox(width: 10.dp),

                            /// 名称
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 200.dp,
                              ),
                              child: Text(
                                nickname,
                                style: TextStyle(
                                  fontSize: 24.dp,
                                  color: paleGreenColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Expanded(child: SizedBox()),

                      Image.asset(
                        "img/Icon/site.png",
                        width: 16.dp,
                        height: 19.dp,
                      ),
                      SizedBox(width: 10.dp),

                      /// 距离
                      Text(
                        item.distance,
                        style: TextStyle(
                          fontSize: 22.dp,
                          color: darkGreyColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<SearchBoxLogic>(builder: (_) {
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
      emptyTips: "抱歉，没有找到相关内容~",

      child: GetBuilder<SearchBoxLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.dp),
          children: [
            for (int i = 0; i < widget.state.list.length; i++)
              item(widget.state.list[i]),

            SizedBox(height: 60.dp),
          ],
        );
      }),
    );
  }

  /// 页面保活
  @override
  bool get wantKeepAlive => true;
}
