import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/index/Recommend.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'package:video_player/video_player.dart';
import '../logic.dart';
import '../state.dart';

/// 首页的tab列表
class TabList extends StatefulWidget {
  const TabList(
      {Key? key,
      required this.state,
      required this.getLogic,
      required this.type})
      : super(key: key);

  /// 逻辑层
  final IndexLogic getLogic;

  /// 数据层
  final IndexState state;

  /// 列表的类型
  final int type;

  @override
  State<TabList> createState() => _TabListState();
}

/// 页面保活  AutomaticKeepAliveClientMixin
class _TabListState extends State<TabList> with AutomaticKeepAliveClientMixin {
  /// 列表的item
  Widget item(Recommend item) {
    return GestureDetector(
      /// 前往详情页
      onTap: () => widget.getLogic.goToSeeDetails(item.id.toString()),
      child: Container(
        height: 238.dp,
        padding: EdgeInsets.symmetric(horizontal: 25.dp),
        margin: EdgeInsets.only(bottom: 30.dp),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/Icon/item_bg.png")),
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
                    "#${widget.state.tabList[item.type]}#",
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
                        onTap: () =>
                            widget.getLogic.goToOthers(item.userId.toString()),
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            /// 头像
                            CircleAvatar(
                              radius: 20.dp,

                              /// 为加载成功时显示的背景色
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  item.userInfo.avatarUrl == ""
                                      ? "${RequestApi.baseUrl}/api/static/boy.png"
                                      : item.userInfo.avatarUrl),
                            ),
                            SizedBox(width: 10.dp),

                            /// 名称
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 200.dp,
                              ),
                              child: Text(item.userInfo.nickname,
                                  style: TextStyle(
                                    fontSize: 24.dp,
                                    color: paleGreenColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 15.dp),
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

                      const Expanded(child: SizedBox()),

                      /// 爱心点赞
                      GestureDetector(
                        onTap: item.giveStatus == 1 ? null : () =>
                            widget.getLogic.giveRelease(item.id, widget.type),
                        child: Row(
                          children: [
                            Image.asset(
                              "img/Icon/${item.giveStatus == 1 ? "love_red" : "love_bai"}.png",
                              width: 26.dp,
                              height: 22.dp,
                            ),

                            SizedBox(width: 15.dp),

                            /// 点赞数
                            Text(
                              item.giveNumber.toString(),
                              style: TextStyle(
                                fontSize: 24.dp,
                              ),
                            ),
                          ],
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
    return GetBuilder<IndexLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (widget.state.reload[widget.type] ?? false) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("页面重新build了-------${widget.type}--------");

    /// 页面保活
    super.build(context);

    /// 刷新和加载组件  自定义widget
    return RefreshLoad(
      /// 初始化请求
      init: (page) => widget.getLogic.getList(widget.type, page),

      /// 用于重置列表
      resetList: (reset) => reload(reset),
      child: GetBuilder<IndexLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.dp),
          children: [
            for (int i = 0; i < widget.state.listMap[widget.type]!.length; i++)
              item(widget.state.listMap[widget.type]![i])
          ],
        );
      }),
    );
  }

  /// 页面保活
  @override
  bool get wantKeepAlive => true;
}
