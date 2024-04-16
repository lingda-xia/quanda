import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/components/refreshLoading/view.dart';
import 'package:quanda/model/publish/ReleaseList.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import '../logic.dart';
import '../state.dart';

/// 互动列表
class Interaction extends StatelessWidget {
  const Interaction({
    Key? key,
    required this.state,
    required this.logic,
  }) : super(key: key);

  /// 数据源
  final MyState state;

  /// 逻辑层
  final MyLogic logic;

  /// 列表item
  Widget listItem(ReleaseList item) {
    return GestureDetector(
      /// 前往详情页
      onTap: () => logic.goToSeeDetails(item.id.toString()),
      child: Container(
        width: 335.dp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.dp),
          color: const Color.fromRGBO(16, 29, 32, 1),
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
            GetBuilder<MyLogic>(builder: (e) {
              return Row(
                children: [
                  SizedBox(width: 15.dp),
                  Text(
                    "#${state.type[item.type]}#",
                    style: TextStyle(
                      fontSize: 26.dp,
                      color: orange,
                    ),
                  ),
                  const Expanded(child: SizedBox()),

                  /// 爱心点赞
                  GestureDetector(
                    onTap: item.giveStatus == 1 ? null : () => logic.giveRelease(item.id),
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

            SizedBox(height: 20.dp),
          ],
        ),
      ),
    );
  }

  /// 用于重置列表
  Widget reload(Function reset) {
    return GetBuilder<MyLogic>(builder: (_) {
      /// 如果状态改变  重置列表
      if (state.reload) {
        reset();
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 刷新和加载组件  自定义widget
    return RefreshLoad(
      /// 初始化请求
      init: (page) => logic.getList(page),

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

      child: GetBuilder<MyLogic>(builder: (_) {
        return ListView(
          children: [
            Wrap(
              spacing: 20.dp,
              runSpacing: 20.dp,
              children: [
                for (int i = 0; i < state.list.length; i++)
                  listItem(state.list[i])
              ],
            ),
          ],
        );
      }),
    );
  }
}
