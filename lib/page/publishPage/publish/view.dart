import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quanda/http/request_api.dart';
import 'package:quanda/utils/function/typedefFunction.dart';
import 'package:quanda/utils/ui/color.dart';
import 'package:quanda/utils/ui/screen.dart';
import 'package:quanda/widget/cached_image.dart';

import 'logic.dart';
import 'state.dart';

/// 发布页面
class Publish extends StatelessWidget {
  Publish({
    Key? key,
  }) : super(key: key);

  /// 逻辑层
  final logic = Get.put(PublishLogic());

  /// 数据层
  final state = Get.find<PublishLogic>().state;

  /// 发布列表的item
  Widget listItem(Release item) {
    return GestureDetector(
      onTap: () => logic.goToPage(item.page),
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.dp),
        child: Row(
          children: [
            SizedBox(width: 110.dp),

            /// 图标
            CachedImage(
              imgUrl: item.img,
              width: 122.dp,
              height: 122.dp,
            ),

            SizedBox(width: 42.dp),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 标题
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 30.dp,
                    color: paleGreenColor,
                  ),
                ),
                SizedBox(height: 10.dp),

                /// 内容
                Text(
                  item.content,
                  style: TextStyle(
                    fontSize: 24.dp,
                    color: const Color.fromRGBO(231, 231, 231, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 60.dp),
          children: [
            SizedBox(height: 150.dp),
            Text(
              "发布",
              style: TextStyle(
                fontSize: 60.dp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30.dp),
            Text(
              "理念很简单 力量不一般",
              style: TextStyle(
                fontSize: 28.dp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 100.dp),

            /// 发布列表
            for (int i = 0; i < state.releaseList.length; i++)
              listItem(state.releaseList[i]),

            SizedBox(height: 130.dp),

            /// 关闭图标
            Container(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => logic.goBack(),
                child: Image.asset(
                  "img/Icon/publishClose.png",
                  width: 98.dp,
                  height: 98.dp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
