import 'package:flutter/material.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/model/chat/SearchEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';
import 'widget/textFieldBox.dart';
import 'package:get/get.dart';
import 'logic.dart';

/// 公共搜索页面
class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  /// 逻辑层
  final logic = Get.put(SearchLogic());

  /// 数据层
  final state = Get.find<SearchLogic>().state;

  /// 列表item
  Widget listItem(SearchEntity item) {
    return GestureDetector(
      onTap: () => logic.seeInformation(item.friendStatus, item.userId),
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.dp),

          Row(
            children: [
              SizedBox(width: 30.dp),

              /// 头像
              ClipRRect(
                borderRadius: BorderRadius.circular(50.dp),
                child: CachedImage(
                  imgUrl: item.avatarUrl,
                  width: 100.dp,
                  height: 100.dp,
                ),
              ),

              SizedBox(width: 25.dp),

              Expanded(
                child: SizedBox(
                  height: 100.dp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// 名称
                      Text(item.nickname),

                      SizedBox(height: 8.dp),

                      /// 标签
                      Text(
                        '#${item.friendStatus ? "朋友" : "陌生人"}#  '
                        '${item.remarkName == "" ? item.introduction : item.remarkName}',
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 24.dp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 30.dp),
            ],
          ),

          SizedBox(height: 20.dp),

          /// 下划线
          Divider(
            height: 1.dp,
            thickness: 1.dp,
            indent: 140.dp,
            color: const Color.fromRGBO(22, 28, 30, 1),
          ),
        ],
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<SearchLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (state.reload) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// 安全区域 不包括状态栏
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 搜索区域
            Container(
              padding: EdgeInsets.all(30.dp),
              child: Row(
                children: [
                  /// 输入框
                  TextFieldBox(
                    /// 数据源
                    state: state,

                    /// 逻辑层
                    logic: logic,
                  ),
                  SizedBox(width: 30.dp),

                  /// 取消并返回上一个页面
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "取消",
                      style: TextStyle(
                        color: const Color.fromRGBO(223, 226, 235, 1),
                        fontSize: 30.dp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 60.dp),

            GetBuilder<SearchLogic>(builder: (_) {
              return Expanded(
                /// 刷新和加载组件  自定义widget  第一次进入页面不显示
                child: state.allow
                    ? RefreshLoad(
                        /// 初始化请求
                        init: (page) => logic.getList(page),

                        /// 用于重置列表
                        resetList: (reset) => reload(reset),

                        /// 是否启用刷新
                        enableRefresh: false,

                        child: ListView(
                          children: [
                            for (int i = 0; i < state.list.length; i++)
                              listItem(state.list[i])
                          ],
                        ),
                      )
                    : Container(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
