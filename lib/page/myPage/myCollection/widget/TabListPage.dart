import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/CollectEntity.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 列表的item
class TabListPage extends StatefulWidget {
  const TabListPage({
    Key? key,
    required this.data,
    required this.type,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final MyCollectionState data;

  /// 逻辑层
  final MyCollectionLogic logic;

  /// 列表的类型
  final int type;

  @override
  State<TabListPage> createState() => _TabListPageState();
}

class _TabListPageState extends State<TabListPage>
    with AutomaticKeepAliveClientMixin {
  /// 列表的item
  Widget item(CollectEntity item) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        margin: EdgeInsets.only(bottom: 30.dp),
        child: Row(
          children: [
            /// 图片展示
            ClipRRect(
              borderRadius: BorderRadius.circular(10.dp),
              child: CachedImage(
                imgUrl: item.fileType == "video" ? item.videoImg! : item.media,
                width: 158.dp,
                height: 158.dp,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 20.dp),

            /// 右侧部分
            Expanded(
              child: SizedBox(
                height: 140.dp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 标题和关闭
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 标题
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 28.dp,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        /// 删除收藏
                        GestureDetector(
                          onTap: () =>
                              widget.logic.openDialog(item.id, widget.type),
                          behavior: HitTestBehavior.translucent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.dp),
                            child: Image.asset(
                              "img/Icon/chacha.png",
                              width: 30.dp,
                              height: 30.dp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.dp),
                    Row(
                      children: [
                        /// 头像
                        CircleAvatar(
                          radius: 21.dp,

                          /// 为加载成功时显示的背景色
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(item.avatarUrl == ""
                              ? "${RequestApi.baseUrl}/api/static/boy.png"
                              : item.avatarUrl),
                          // "${RequestApi.baseUrl}/api/static/boy.png"),
                        ),

                        SizedBox(width: 10.dp),

                        /// 用户名称
                        Expanded(
                          child: Text(
                            item.nickname,
                            style: TextStyle(
                              fontSize: 24.dp,
                              color: greyColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 20.dp),

                        /// 时间
                        Text(
                          item.createTime,
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
            ),
          ],
        ),
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<MyCollectionLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (widget.data.reload[widget.type] ?? false) {
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
      emptyTips: "您还没有收藏任何东西~",

      /// 加载为空的图片widget
      emptyWidget: Image.asset(
        "img/bigIcon/collection_empty.png",
        width: 542.dp,
        height: 318.dp,
      ),

      child: GetBuilder<MyCollectionLogic>(builder: (_) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 35.dp),
          children: [
            for (int i = 0; i < widget.data.listMap[widget.type]!.length; i++)
              item(widget.data.listMap[widget.type]![i])
          ],
        );
      }),
    );
  }

  /// 页面保活
  @override
  bool get wantKeepAlive => true;
}
