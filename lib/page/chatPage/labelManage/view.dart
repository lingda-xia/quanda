import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/model/chat/LabelEntity.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';

/// 标签管理页面
class LabelManage extends StatelessWidget {
  LabelManage({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(LabelManageLogic());

  /// 数据层
  final state = Get.find<LabelManageLogic>().state;

  /// 列表item
  Widget listItem(LabelEntity item) {
    return GestureDetector(
      onTap: () => logic.goToSetLabel(item.id, item.name),
      child: Container(
        width: 335.dp,
        height: 195.dp,
        decoration: BoxDecoration(
          color: blackGrey,
          borderRadius: BorderRadius.circular(10.dp),
        ),
        child: Stack(
          children: [
            /// 标签和该标签的好友
            Padding(
              padding: EdgeInsets.all(12.dp),
              child: Column(
                children: [
                  /// 标签和数量
                  Row(
                    children: [
                      Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 30.dp,
                        ),
                      ),
                      Text(
                        "（${item.friendCount}）",
                        style: TextStyle(
                          fontSize: 24.dp,
                          color: const Color.fromRGBO(146, 149, 158, 1),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.dp),

                  /// 所在标签的朋友名字
                  Text(
                    item.tagFriendName,
                    style: TextStyle(
                      fontSize: 22.dp,
                      color: greyColor,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            /// 关闭图标
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () => logic.tagDel(item.id.toString()),
                behavior: HitTestBehavior.translucent,
                child: Image.asset(
                  "img/Icon/guanbi.png",
                  width: 49.dp,
                  height: 36.dp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// 回退键
        leading: const BackButton(),
        title: const Text("标签管理"),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.dp),
        children: [
          /// 流式布局
          GetBuilder<LabelManageLogic>(builder: (_) {
            return Wrap(
              runSpacing: 25.dp,
              spacing: 20.dp,
              children: [
                /// 新建标签
                GestureDetector(
                  onTap: () => logic.goToNewLabel(),
                  child: Container(
                    width: 335.dp,
                    height: 195.dp,
                    decoration: BoxDecoration(
                      color: blackGrey,
                      borderRadius: BorderRadius.circular(10.dp),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Image.asset(
                          "img/Icon/jiahao.png",
                          width: 58.dp,
                          height: 58.dp,
                        ),

                        SizedBox(height: 10.dp),

                        Text(
                          "新建标签",
                          style: TextStyle(
                            color: const Color.fromRGBO(187, 187, 187, 1),
                            fontSize: 24.dp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 标签列表
                for (int i = 0; i < state.list.length; i++)
                  listItem(state.list[i]),
              ],
            );
          })
        ],
      ),
    );
  }
}
