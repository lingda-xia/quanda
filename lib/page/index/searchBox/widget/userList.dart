import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/model/index/UserSearch.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import '../logic.dart';
import '../state.dart';

/// 首页搜索的 用户 tab列表
class UserList extends StatefulWidget {
  const UserList(
      {Key? key, required this.state, required this.logic, required this.type})
      : super(key: key);

  /// 逻辑层
  final SearchBoxLogic logic;

  /// 数据层
  final SearchBoxState state;

  /// 列表的类型
  final int type;

  @override
  State<UserList> createState() => _UserListState();
}

/// 页面保活  AutomaticKeepAliveClientMixin
class _UserListState extends State<UserList>
    with AutomaticKeepAliveClientMixin {

  /// 列表的item
  Widget item(UserSearch item) {
    return GestureDetector(
      /// 前往详情页
      onTap: () => widget.logic.seeInformation(item.friendStatus, item.userId),
      child: Container(
        height: 160.dp,
        padding: EdgeInsets.symmetric(horizontal: 40.dp),
        margin: EdgeInsets.only(bottom: 30.dp),
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("img/Icon/userBox.png")),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            /// 媒体展示
            ClipRRect(
              borderRadius: BorderRadius.circular(50.dp),
              child: CachedImage(
                imgUrl: item.avatarUrl,
                width: 100.dp,
                height: 100.dp,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 20.dp),

            Expanded(
              child: SizedBox(
                height: 100.dp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nickname,
                      style: TextStyle(
                        fontSize: 28.dp,
                      ),
                    ),
                    SizedBox(height: 10.dp),
                    Text(
                      "简介：${item.introduction}",
                      style: TextStyle(
                        fontSize: 24.dp,
                        color: greyColor,
                      ),
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
            for (int i = 0; i < widget.state.userList.length; i++)
              item(widget.state.userList[i]),

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
