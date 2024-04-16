import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/personal/FollowEntity.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';

import '../logic.dart';
import '../state.dart';

/// 列表的item
class TabList extends StatefulWidget {
  const TabList({
    Key? key,
    required this.state,
    required this.type,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final FansFollowState state;

  /// 逻辑层
  final FansFollowLogic logic;

  /// 列表的类型
  final int type;

  @override
  State<TabList> createState() => _TabListState();
}

class _TabListState extends State<TabList> with AutomaticKeepAliveClientMixin {
  /// 边框按钮
  Widget frameButton(String title) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        height: 54.dp,
        width: 106.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: paleGreenColor,
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: paleGreenColor,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  /// 灰色按钮
  Widget greyButton(String title) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        height: 54.dp,
        width: 106.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: darkGreyColor,
            width: 2.dp,
          ),
          borderRadius: BorderRadius.circular(29.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: darkGreyColor,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  /// 背景按钮
  Widget bgButton(String title) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 106.dp,
        height: 54.dp,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: paleGreenColor,
          borderRadius: BorderRadius.circular(27.dp),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.dp,
          ),
        ),
      ),
    );
  }

  /// 列表的item todo
  Widget item(FollowEntity item) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.dp),
      child: Row(
        children: [
          /// 头像
          CircleAvatar(
            radius: 50.dp,

            /// 为加载成功时显示的背景色
            backgroundColor: Colors.white,
            backgroundImage:
                const NetworkImage("${RequestApi.baseUrl}/api/static/boy.png"),
          ),
          SizedBox(width: 20.dp),

          /// 用户名
          Expanded(
            child: Text(
              "名字说过的话豆腐花大会的和",
              style: TextStyle(
                fontSize: 28.dp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 20.dp),

          /// 移除
          frameButton("移除"),
          SizedBox(width: 20.dp),

          /// 回关
          bgButton("回关"),
          SizedBox(width: 10.dp),
          // greyButton("互关"),
        ],
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<FansFollowLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if(widget.state.reload[widget.type] ?? false) {
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
      child: GetBuilder<FansFollowLogic>(builder: (_) {
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
